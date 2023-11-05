---
title: Créer des exécutables Python
date: 2023-06-13 00:00:00
categories: [dev, python]
tags: [python, dev, build, executable]
---

There is several tools to create an executable from a Python script. In this article, I will present two of them: auto-py-to-exe and PyInstaller.

# auto-py-to-exe

Auto-py-to-exe is a tool that allows the conversion of a Python script into a standalone executable for Windows. The process of creating a Python executable using this tool involves several steps but can be easily accomplished with the help of the graphical interface provided by auto-py-to-exe.

To install auto-py-to-exe, the following command can be used:

```bash
pip install auto-py-to-exe
```

Once auto-py-to-exe is installed, the tool can be launched. To launch the tool, you have to execute the script `auto-py-to-exe`. It can be found in the directory `Scripts` of the Python installation directory. Most of the time, the Python installation directory is `C:\Users\<user>\AppData\Local\Programs\Python\<version>\Scripts`.

The next step is to configure the parameters for the conversion process. This includes **selecting the Python script** to be converted, **specifying the output directory** for the generated executable, and optionally **choosing a custom icon**. **Additional files** that are required for running the script can also be included. For example, if you code a game with Pygame, you can include the sprites and the sounds in the executable.

After configuring the parameters, the conversion process can be initiated by clicking the corresponding button in the auto-py-to-exe graphical interface. **PyInstaller**, which is used internally by auto-py-to-exe, is responsible for generating the executable from the Python script.

Once the conversion is complete, **the generated executable can be found in the specified output directory**. It can be run on a Windows system without the need for Python to be installed.

It is important to note that the compatibility of the executable with different Windows systems may vary depending on factors such as external dependencies and Python versions. Therefore, careful consideration should be given to these factors to ensure compatibility. Your project may require the installation of additional packages. In this case, it is recommended to use a virtual environment to install the packages and to include the virtual environment in the executable.

# PyInstaller

#### Resources and documentation

[Tutoriel Python créer un exécutable - Youtube](https://www.youtube.com/watch?v=Jji2ik_AQOg)
[auto-py-to-exe - pypi](https://pypi.org/project/auto-py-to-exe/)
[PyInstaller - pypi](https://pypi.org/project/PyInstaller/)
[PyInstaller - documentation](https://pyinstaller.org/en/stable/)