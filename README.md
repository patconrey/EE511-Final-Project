This is the final proejct for EE511

**Instructions**: Modulate and demodulate the most bits through the given channel. Only 0 bit error is allowed.

**Submission**: As in V4 and V5, just send your *.m files. 

**Scoring**: This is a competitive format so the scoring is based on a dynamic scale. The “Performance is  Nbits * 100/ Nbmax. The last column is also dynamic and meant to spread the results between 80 and 100. So SCORE = A * Nbits + B where A and B are determined as A=20/(Nbmax-Nbmin) and B=100-A*Nbmax. Nbmax is the highest number of bits transmitted and received without error based on the baseline and group performance. Nbmin is the lowest Nbits of the groups.

**Project Structure**: So the main reason why I want to use Git for this project is becuase it allows us to branch. Here's what I'm thinking: the Master branch has the baseline working code that will get us at least minimal credit for submitting. If we want to try a new method, we can branch off of master. Once we can outperform our baseline, we merge that branch into Master and that becomes our new baseline. Git is excellent for this type of work as well as tracking the project throughout time. It will let us easily maintain the project and see latest updates. 

**Testing**: Make a test file for the method!

**Common Files**: All the modulation and demodulation techniques rely on four common files: 
1. `FTSIO_createBsize`
2. `Bgen18`
3. `channel18B`
4. `bitcheck18`

To change the number of bits under test, edit `FTSIO_createBsize`.

**Our Scores**:

Test

| Branch ID    | Bit Rate       |
| :---         |     :---:      |
| MASTER	   |          	    |
| _BASELINE_   | 65536       	|

