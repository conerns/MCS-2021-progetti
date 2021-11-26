# Metodi del Calcolo Scientifico/Scientific computing methods - 2021
In this repo you will find the project, we as a team, developed for the scientific computing methods course. </br>
The project is divided into 2 distinct parts:
## Part 1: Direct methods for sparse matrix (Python, Matlab, GNU octave)
For direct methods we intend the fact that the programming language/software could perform the linear system Ax=b. <br> 
The aim of this part is to show if open source softwares/programming languages are better, or worse, than proprietary ones. The test was conducted both on Windows 10 and Ubuntu 18.04 LTS </br>
We confronted <b>Matlab</b>, a property programming language, with <b>Octave</b> and <b>python</b>, in particular using numpy and scipy libraries. <br>
The metrics used to perform the comparison being: memory usage, time to solve the system and the accuracy of the solution.

## Part 2: Images compression (Python)
The aim of this project was to study of the Discrete Cosine Transformation to perform image compression. In particular, this project is divided into two parts:
<ul>
  <li> Implementation of DCT2 and comparison of results with built in libraries that implement fast fourier transformation. </li>
  <ul>
     <li> Development of the algorithm for the calculation of the DCT.
     <li> Execution of the DCT through the functions of the open source library and the function developed by us, collecting the execution times
     <li> Comparison of execution times collected.
  </ul>
  <li> Creation of an software that allows us to concretely visualize the functioning of the DCT2 applied to the images. </li>
     We developed an application that allows you to compress a bitmap image. The developed application has the following features:
    <ul>
      <li> Graphic interface, created using the Tkinter librar, for selecting images and parameters</li>
      <li> Display of the starting image and the image produced by the algorithm</li>
      <li> Running the compression algorithm on the image and show the result to the user</li>
    </ul>
</ul>
