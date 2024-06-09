#include <mex.h>
#include <fstream>
#include <vector>
#include <set>
#include <string>
#include <cctype>

using std::vector;

void print_usage() {
	mexPrintf("[C,M] = extract_polynomials(filename,n_vars)\n");
}

class Monomial {
public:
	Monomial(int n_vars)
	{
		pow.resize(n_vars,0);
	}	
	void print() const {
		mexPrintf("[");
		for(int k = 0; k < pow.size(); k++) {
			mexPrintf("%d,",pow[k]);
		}
		mexPrintf("]\n");
	}
	std::vector<int> pow;
};



void debug_print(std::ifstream &input, std::string tag) {
	int pos0 = input.tellg();
	mexPrintf("DEBUG:(%s) '",tag.c_str());
	for(int k = 0; k < 20; k++) {		
		mexPrintf("%c",input.get());
	}
	mexPrintf("'\n");
	input.clear();
	input.seekg(pos0);	
}


int read_number(std::ifstream &input)
{
	int num;

	if(!isdigit(input.peek())) {
		mexPrintf("ERROR: Expected number. Actual: '%c'\n",input.peek());
		input.close();
		return 0;
	}


	input >> num;
	return num;
}

void parse_factor(std::ifstream &input, double &coeff, Monomial &output)
{
	// [\d* | x\d | x\d^\d ]
//	debug_print(input,"parse_factor");
	char c = input.peek();

	if(isdigit(c)) {
        if(c == '0') {
            // we have a zero element in the matrix
            coeff = 0;
            input.get();
            output.pow.clear();
        } else {
            // read the rest of the numbers
           	if(isdigit(input.peek()))
           		input >> coeff;

           	if(isdigit(input.peek())) {
           		mexPrintf("ERROR: expected non-digit. Actual: '%c'\n",input.peek());
           		input.close();
           	}

            while(isdigit(input.peek()))
                input.get();	
        }
	} else if(c == 'x') {
		input.get();
		int k = read_number(input)-1;
		int p = 1;

		// check for higher powers
		if(input.peek() == '^') {
			input.get();
			p = read_number(input);
		}
		output.pow[k] = p;
	} else {
		mexPrintf("ERROR: expected number or 'x'. Actual: '%c\n'",c);
		input.close();
	}
}


void parse_term(std::ifstream &input, std::vector<double> &cc, std::vector<Monomial> &mm, int n_vars)
{
	// factor[\*factor]*
//	debug_print(input,"ENTER:parse_term");
	Monomial mon(n_vars);
	double coeff = 1.0;
	parse_factor(input,coeff,mon);
	while(input.peek() == '*') {
		input.get();
		parse_factor(input,coeff,mon);
	}
//	debug_print(input,"END:parse_term");
    if(mon.pow.size()>0) {
    	cc.push_back(coeff);
        mm.push_back(mon);
    }
}
void parse_polynomial(std::ifstream &input, std::vector<double> &cc, std::vector<Monomial> &mm, int n_vars)
{
	// [-?]term([+|-]term)*
//	debug_print(input,"ENTER:parse_polynomial");
	// check for -
	if(input.peek() == '-') {
		input.get();
		parse_term(input,cc,mm,n_vars);
		cc[0] = -cc[0];
	} else {
		parse_term(input,cc,mm,n_vars);
	}


	while(input.peek() == '+' || input.peek() == '-') {
		char c = input.get();
		parse_term(input,cc,mm,n_vars);
		if(c == '-') {
			cc[cc.size()-1] = -cc[cc.size()-1];
		}

	}
//	debug_print(input,"END:parse_polynomial");
}



void skip_whitespace(std::ifstream &input)
{
	while(isspace(input.peek()))
		input.get();
}

bool skip_until_matrix(std::ifstream &input) {
    std::string str = "matrix {{";
    
    int pos = 0;
    
    while(!input.eof() && input.is_open()) {        
        char c = input.get();
        if(c == str[pos]) {
            pos++;
            // check if we are done
            if(pos == str.length())                
                return true;
        } else {
            pos = 0;
        }   
    }
    return false;
}



void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	if(nrhs != 2 || nlhs != 2) {
		print_usage();
		return;
	}


	char* filename = mxArrayToString(prhs[0]);	
	int n_vars = static_cast<int>(*mxGetPr(prhs[1]));


	char buf[8192];

	std::ifstream input(filename);
	input.rdbuf()->pubsetbuf(buf, 8192);

    if(!skip_until_matrix(input)) {
        mexPrintf("ERROR: Unable to find start of matrix!\n");
        return;
    }    

	vector<vector<vector<double>>> all_cc;
	vector<vector<vector<Monomial>>> all_mm;
	
	all_cc.push_back(vector<vector<double>>());
	all_mm.push_back(vector<vector<Monomial>>());

	int row_k = 0;
	int col_k = 0;
	bool done = false;

	while(!done) {
		if(!input.is_open())
			break;


		vector<double> coeffs;
		vector<Monomial> mons;

		parse_polynomial(input,coeffs,mons,n_vars);		

		all_cc[row_k].push_back(coeffs);
		all_mm[row_k].push_back(mons);

		// check if we have more on this column		
		if(input.peek() == ',') {
			input.get();
			col_k = col_k + 1;
			skip_whitespace(input);
		} else if(input.peek() == '}') {
			// end of column
			input.get();
						
			if(input.peek() == ',') {
				// next row
				input.get();
				row_k = row_k + 1;	
				col_k = 0;	
				skip_whitespace(input);
				input.get(); // '{'

				all_cc.push_back(vector<vector<double>>());
				all_mm.push_back(vector<vector<Monomial>>());

			} else if(input.peek() == '}') {
				// we are done now
				done = true;


			} else {
				mexPrintf("ERROR: expected ',' or '}'. Actual: '%c'\n",input.peek());
				input.close();
				return;
			}
		}
	}



	int n_rows = all_cc.size();
	int n_cols = (n_rows == 0) ? 0 : all_cc[0].size();

	// create output array	
	mxArray* output_cc = mxCreateCellMatrix(n_rows,n_cols);
	mxArray* output_mm = mxCreateCellMatrix(n_rows,n_cols);
	plhs[0] = output_cc;
	plhs[1] = output_mm;
	for(int row_k = 0; row_k < n_rows; row_k++) {		
		for(int col_k = 0; col_k < n_cols; col_k++) {	


			std::vector<double> coeffs = all_cc[row_k][col_k];
			std::vector<Monomial> mons = all_mm[row_k][col_k];			

			// convert results to matlab arrays
			mxArray* m = mxCreateDoubleMatrix(n_vars, mons.size(), mxREAL);
			mxArray* c = mxCreateDoubleMatrix(1, mons.size(), mxREAL);
			double *data_m = mxGetPr(m);
			double *data_c = mxGetPr(c);
			int i = 0;
			for(int i = 0; i < mons.size(); i++) {
				for(int k = 0; k < n_vars; k++) {
					data_m[i*n_vars+k] = mons[i].pow[k];
				}	
				data_c[i] = coeffs[i];			
  			}	  			

  			// save to cell array
			int index = col_k*n_rows + row_k;
			mxSetCell(output_cc,index,c);	
			mxSetCell(output_mm,index,m);
		}
	}


	
}
