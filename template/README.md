# File Structure
- Per SDK 4.2

- /support/ - raw/art files. Excluded by .gitignore
- /builds/ - Builds of the project. Excluded by .gitignore
- /source/ - Contains the source files for the project
    - /images/ - Contains the sprite files for the project
    - /sounds/ - Contains the sound files for the project
        - main.lua - Where the game starts
        - pdxinfo - Contains information about the project

# Compiling

- Make sure that the SDK is on path.
```bash
$ export PATH=$PATH:/path/to/sdk
```

- Run "make" in the root directory of the project
```bash
$ make
```
