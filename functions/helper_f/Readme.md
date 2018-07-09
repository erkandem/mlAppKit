[![MATLAB FEX](https://img.shields.io/badge/MATLAB%20FEX-mlapp2classdef-brightgreen.svg)](http://www.mathworks.com/matlabcentral/fileexchange/56237-mlapp2classdef) ![Minimum Version](https://img.shields.io/badge/Requires-R2013b%20%28v8.2%29-orange.svg)

# mlapp2classdef

MLAPP2CLASSDEF converts an App Designer GUI's class definition, packaged as a `*.mlapp` file, from XML to a standalone `*.m` class definition.

The class definition for an App Designer GUI is embedded in an XML file located in a subfolder of the packaged `*.mlapp` file, which can be accessed like a `*.zip` file. MLAPP2CLASSDEF strips the XML header & footer and saves the class definition to a `*.m` file located in the same path as the `*.mlapp` file.

## Syntax

`MLAPP2CLASSDEF()` prompts the user to select `*.mlapp` file(s) for processing. Selection of multiple files in the same directory is supported.

`MLAPP2CLASSDEF(pathToMLapp)` processes the files specified by the user. `pathToMLapp` can be a string for a single file or a cell array of strings for multiple files. Filepaths should be absolute.

`MLAPP2CLASSDEF(..., 'ReplaceAppUI', flag)` allows the user to specify whether to replace App Designer UI elements with their "regular" MATLAB equivalents (e.g. App Designer uses `uifigure` where MATLAB uses `figure`). `flag` is a boolean value whose default is `false`. To prompt the user to select a `*.mlapp` file with this syntax, pass an empty first argument (e.g. `MLAPP2CLASSDEF([], 'ReplaceAppUI', true)`).

### Examples

    % MATLAB prompts user for file(s) to process:
    mlapp2classdef()

    % Process single user specified file:
    myguipath = 'C:\myfolder\mygui.mlapp';  % A single cell is also supported
    mlapp2classdef(myguipath)

    % Process multiple user specified files:
    myguipaths = {'C:\myfolder\mygui.mlapp', 'C:\myfolder\mygui2.mlapp'};
    mlapp2classdef(myguipaths)

    % Prompt user for file(s), replacing UI elements:
    mlapp2classdef([], 'ReplaceAppUI', true)

    % Process multiple user specified files, replacing UI elements:
    myguipaths = {'C:\myfolder\mygui.mlapp', 'C:\myfolder\mygui2.mlapp'};
    mlapp2classdef(myguipaths, 'ReplaceAppUI', true)

# Current Limitations

MLAPP2CLASSDEF assumes that the targeted `*.mlapp` file is a GUI created by MATLAB's App Designer. Other packaged apps are not explicitly supported.

Structure of the packaged `*.mlapp` file is assumed to be a constant (e.g. `~\matlab\document.xml` is the path to the class definition XML). This is only relevant when utilizing MLAPP2CLASSDEF in MATLAB versions older than R2014b.

Replacement of App Designer specific GUI elements with their "regular" MATLAB equivalents is a work in progress. See the below table for a description of UI element support. Many property definitions reference components and/or properties introduced in MATLAB R2016a and cannot be robustly translated to older versions of MATLAB. These function calls are left as-is for the user to handle translation.

UI Element    | App Designer Function | "Regular" MATLAB Function            | Conversion Supported | Caveats
:------------ | :-------------------- | :----------------------------------- | :------------------: | :------
Figure        | `uifigure`            | `figure`                             | Yes                  | Does not modify any input parameters
Axes          | `uiaxes`              | `axes`                               | Yes                  | Does not modify any input parameters
Button        | `uibutton`            | `uicontrol('Style', 'pushbutton')`   | Yes                  | Modifies inputs, assumes only App Designer input is parent object
Checkbox      | `uicheckbox`          | `uicontrol('Style', 'checkbox')`     | Yes                  | Modifies inputs, assumes only App Designer input is parent object
Edit Box      | `uieditfield`         | `uicontrol('Style', 'edit')`         | Yes                  | Modifies inputs, assumes only App Designer input is parent object
Text Label    | `uilabel`             | `uicontrol('Style', 'text')`         | Yes                  | Modifies inputs, assumes only App Designer input is parent object
List Box      | `uilistbox`           | `uicontrol('Style', 'listbox')`      | Yes                  | Modifies inputs, assumes only App Designer input is parent object
Radio Button  | `uiradiobutton`       | `uicontrol('Style', 'radiobutton')`  | Yes                  | Modifies inputs, assumes only App Designer input is parent object
Slider        | `uislider`            | `uicontrol('Style', 'slider')`       | Yes                  | Modifies inputs, assumes only App Designer input is parent object
Toggle Button | `uitogglebutton`      | `uicontrol('Style', 'togglebutton')` | Yes                  | Modifies inputs, assumes only App Designer input is parent object
Spinner       | `uispinner`           | N/A                                  | No                   | N/A    
Text Area     | `uitextarea`          | N/A                                  | No                   | N/A    
Gauge         | `uigauge`             | N/A                                  | No                   | N/A    
Knob          | `uiknob`              | N/A                                  | No                   | N/A    
Lamp          | `uilamp`              | N/A                                  | No                   | N/A    
Switch        | `uiswitch`            | N/A                                  | No                   | N/A    
UI Alert      | `uialert`             | N/A                                  | No                   | N/A    

Most converted GUIs will likely still require MATLAB R2014b and newer. MATLAB's App Designer heavily utilizes the dot notation for accessing properties of UI elements rather than using `set` and `get`. See [Graphics Handles Are Now Objects, Not Doubles](http://www.mathworks.com/help/matlab/graphics_transition/graphics-handles-are-now-objects-not-doubles.html) for more information.
