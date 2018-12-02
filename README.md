This is the project for EE511 Project B.

**Instructions**: There are 4 parts of the Project B which are worth 25% each:
1. AM, 
2. DSBSC,
3. FM, and
4. DSSS modulation and demodulation. 

Each part must result in **0 bit error** and you must stay with the associated modulation technique. But you may use any demodulation technique you want as long as it is not accessing the original bit sequence. You can assume as before that the demodulator knows where the bit centers are but does not know the bit values. 

_N.B_: For DSSS, you should probably modify the GenDsssKeys.m function to include the Channel18B frequency response and add your group alias to the name which means you will also need to change the function name and change the call to the function in alias_dsssKeygenV5.m.

**Submission**: As in V4 and V5, just send your *.m files. 

**Scoring**: The team with the most bits without error in each part will receive full credit for that part. Bit rates below the maximum will receive points less than the 25% for each part of Project B. 

**Testing**: Every type of modulation and demodulation has a script associated with it to test, `*_test.m`. The script runs a second script called `cleanup.m` which will delete all current `.jpg`s and `.mat`s from the current directory. It also clears the workspace and closes all figures. After adding in a modulation/demodulation technique, write a test file.

**Common Files**: All the modulation and demodulation techniques rely on four common files: 
1. `FTSIO_createBsize`
2. `Bgen18`
3. `channel18B`
4. `bitcheck18`

To change the number of bits under test, edit `FTSIO_createBsize`.

**Our Scores**:

| Branch ID    | AM             | DSBSC         | FM            | DSSS          | Average       |
| :---         |     :---:      |     :---:     |   :---:       |     :---:     |     :---:     |
| MASTER	   | X   	        | 38000 	    | 30000  	    | 30000  	    | X             |

