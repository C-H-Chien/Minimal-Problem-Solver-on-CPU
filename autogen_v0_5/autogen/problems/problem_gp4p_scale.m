function [ eqs, data0, eqs_data ] = problem_gp4p_scale( data0 )

if nargin < 1 || isempty(data0)
    data0 = randi(50,13*6,1);
end

b = reshape(data0,13,6);

xx = create_vars(5);

bb = b*[xx;1];

R = reshape(bb(1:9),3,3)';

len_c = sum(R.^2,1);
len_r = sum(R.^2,2);

eqs = [len_r(1)-len_r(2);
       len_r(1)-len_r(3);
       len_c(1)-len_r(2);
       len_c(1)-len_c(3);
       R(1,:)*R(2,:)';
       R(1,:)*R(3,:)';
       R(2,:)*R(3,:)';
       R(:,1)'*R(:,2);
       R(:,1)'*R(:,3);
       R(:,2)'*R(:,3)];


if nargout == 3


    xx = create_vars(5+13*6);
    
    data = xx(6:end);
    b = reshape(data,13,6);

    bb = b*[xx(1:5);1];

    R = reshape(bb(1:9),3,3)';

    len_c = sum(R.^2,1);
    len_r = sum(R.^2,2);

    eqs_data = [len_r(1)-len_r(2);
           len_r(1)-len_r(3);
           len_c(1)-len_r(2);
           len_c(1)-len_c(3);
           R(1,:)*R(2,:)';
           R(1,:)*R(3,:)';
           R(2,:)*R(3,:)';
           R(:,1)'*R(:,2);
           R(:,1)'*R(:,3);
           R(:,2)'*R(:,3)];

end

