# Minimal Problem Solvers in CPU
### Research @ LEMS, Brown University
## Introduction
This repository hosts three CPU-based solvers, namely, _(i)_ elimination template, _(ii)_ Julia, and _(iii)_CPU-HC which is my own implementation, for minimal problems in various computer vision tasks, with documentations on how they can used effectively. <br />

## Elimination Template
All the code, under ``autogen_v0_5`` is borrowed from an old (but now probably vanished) repository from Prof. Viktor Larsson. You can run minimal problems that were already contained in the code, or add your own minimal problem with ease effort. Refer to (How to build your Elimination Template solver)[(https://github.com/C-H-Chien/Minimal-Problem-Solver-on-CPU/blob/main/EliminationTemplate.md)] for more information. 

## Julia
Example Julia code are under ``Julia-HC-Solver/``, where you can provide an explicit polynomial system as illustrated in ``4view_triangulation.jl``, or you can build the problem in Julia as illustrated in ``trifocal_2op1p_30x30.jl``. In either case, a start system (start parameters + start solutions) can be created by Julia's monodromy solver, or it could be explicitly provided by the user. <br />

To run Julia's homotopy continuation solver using multi-core CPUs, say 8-cores CPUs, start the Julia by
```bash
JULIA_NUM_THREADS=8 ./julia
```
and you can check the number of cores used in Julia by
```julia
Threads.nthreads()
```
which shall return 8. 

## My CPU-HC Implementation
(Will update soon)


## :bookmark: References
If you use elimination template, please cite:
```BibTeX
@inproceedings{larsson2017efficient,
  title={Efficient solvers for minimal problems by syzygy-based reduction},
  author={Larsson, Viktor and Astrom, Kalle and Oskarsson, Magnus},
  booktitle={Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition},
  pages={820--829},
  year={2017}
}
```
If you use Julia, please cite:
```BibTeX
@inproceedings{breiding2018homotopycontinuation,
  title={HomotopyContinuation. jl: A package for homotopy continuation in Julia},
  author={Breiding, Paul and Timme, Sascha},
  booktitle={Mathematical Software--ICMS 2018: 6th International Conference, South Bend, IN, USA, July 24-27, 2018, Proceedings 6},
  pages={458--465},
  year={2018},
  organization={Springer}
}
```
If you use my own implementation, please cite my GPU-HC paper:
```BibTeX
@inproceedings{chien2022gpu,
  title={GPU-based homotopy continuation for minimal problems in computer vision},
  author={Chien, Chiang-Heng and Fan, Hongyi and Abdelfattah, Ahmad and Tsigaridas, Elias and Tomov, Stanimire and Kimia, Benjamin},
  booktitle={Proceedings of the IEEE/CVF Conference on Computer Vision and Pattern Recognition},
  pages={15765--15776},
  year={2022}
}
```