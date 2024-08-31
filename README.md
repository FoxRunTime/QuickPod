# QuickPod
Self-contained installer script project for the QEMU-iOS project, designed for the Mac. 

----


### Technical:
This script has two distinct versions:

* QuickPod-ARM is designed for Apple Silicon Macs.
* QuickPod-X86 is designed for Intel-based Macs.
  
_You can check which you need by going to the Apple Menu and selecting **About This Mac.** If the first line of information has the word **Chip**, you have an Apple Silicon Mac. If it says **Processor**, you have an Intel-based Mac._

----

### Disclaimer: 
* I am not responsible for any harm done to your computer.
* I have extensively tested this script on my personal machine (M1 MacBook Air) and can certify that it does not cause any data loss. 
* If you do not trust me, do not run my software on your machine. Do not blindly trust random users online. Read the source code and verify its function.
* I am in no way affiliated with anyone working on the QEMU-iOS project. _This project simply aims to make experiencing that project easier._


### Why does this exist?
This project was created to solve a very specific problem with setting up an instance of [QEMU-iOS](https://github.com/devos50/qemu-ios): ![image](https://github.com/user-attachments/assets/19e044cc-e26b-4f40-9582-2e0fc0aea1a0)

Compiler errors and dependency troubles make setting this up way harder than necessary, and some curious hobbyists have gotten annoyed by this and have given up entirely. This script aims to remedy this.

----

### How does it work?
I mean, you _could_ read the source code (I commented it out!), but I digress.
I'll make it simple:

1: It goes to your home directory and makes a new folder called 'ipod2' and enters it. 

2: It downloads the ROM, NOR, and NAND from this source: https://github.com/devos50/qemu-ios/releases/tag/n72ap_v1

2a: then puts them in the ipod2 folder.

3: It extracts the NAND (it ships as a .zip archive), then deletes the .zip to preserve storage space.

4: It goes back into your home directory and clones the qemu-ios repo then enters the resulting directory. 

5: It installs any required dependencies via Homebrew.

6: It does some configuration, preparing to compile QEMU.

7: It compiles QEMU.

8: It creates a simple bash script file (boot_ipod.sh) and puts it on your Desktop.

9: Assuming all went well, it should launch QEMU and boot into iOS 2.2.1. 

When you're done, you can just close the window. If you want to relaunch it, open a new Terminal window, cd to the Desktop, and type `./boot_ipod.sh`.

