
Cut out from Readme
==========================



State of App Designer
----------------------
using MATLAB App Designer (AD) is almost as easy as working with a spreadsheets. 
However, anyone with some experience with spreadsheets, knows that with 
increasing complexity you're likly to hit an efficiency wall.
It is not different with AD:

#. slows down the editor
#. doesn't offer code folding
#. doesn't have a visual hierarchy on the code level
#. editable area is safe guarded
#. favors a monolithic design structure
#. which then is hard to maintain and keep tidy and
#. makes it more painful to introduce new features

As a result apps tend to be single use apps.

Existing Workarounds
---------------------

Most of the issues can be simply avoided by calling an external script, function, class or application from within the editable area:

.. code:: matlab

   function callbackOfSomeUserInterfaceElementPushed(app, event)
       someFunctionLocatedInAnOtherFile(app, event);
   end


Functions are favorable to scripts since they offer separate namespaces.
Classes can be great to work with. Maintaining function might be easier.

Linking different apps from  one central app is is an intuitive way to go.
However, I would not like to open, rearrange and close ten different windows during my workflow.

Tabs and panels offer a simple way to structure different parts of an app.
Unfortunately this structure is not reflected in the code base.
Except, if someone would be chuzpe enough to use container UI elements as **namespaces**. 
The key to the success of this approach would be:

:Goal: retaining the visual  drag and drop user experience and add as little pain as possible

Is there a way to bridge the gap between programmatic and visual app design in MATLAB?
Since .mlapp files are container files the source code could be modified and zipped back.
While it sounds like a easy patch. Note that surgery is avoided for a reason.
It may work now, but the next version could break everything. [alpha]_
In other words the procedure should be noninvasive - or - at least not rely upon keeping the patient alive.

.. [alpha] Some analysis on the .mlapp file format `<https://undocumentedmatlab.com/blog/appdesigner-mlapp-file-format>`_

Approach Presented Via **mlAppKit**
-----------------------------------
This toolkit offers relief. 

Extract Code from .mlapp
^^^^^^^^^^^^^^^^^^^^^^^^^^


in courtesy of `StackOverflowMATLABchat <https://github.com/StackOverflowMATLABchat>`_

.. code:: matlab
   
   evalcstr = sprintf('type(''%s‘’)’, 'app.mlapp'));
   myMcode  = evalc(evalcstr); % evalcstr: 'type('app.mlapp')'


Theory
---------------

Anatomy
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Let's ... borrow ... the concept of **views** and **activities** from
other IDEs such as Android Studio or any other.

Going through the possible combinations I came up with three different
views/activities:

-  **host** which has a ``UI Figure`` serving as a socket

-  **plugins** which (each) have a ``UI Panel`` as the highest
   structural element

-  **popups** with an ``UI Figure`` to save real estate

   +-----------------------------+---------------+--------------+-------+
   |                             | host          | plugin       | popup |
   +=============================+===============+==============+=======+
   | highest structural element  | ``UI Figure`` | ``UI Panel`` | both  |
   +-----------------------------+---------------+--------------+-------+
   | can live...                 | autonomous    | dependent    | both  |
   +-----------------------------+---------------+--------------+-------+
   | serves as...                | socket board  | content      | both  |
   +-----------------------------+---------------+--------------+-------+

Project File and Folder  Structure
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code:: bash

   .
   ├── mlAppKit                      # project folder
   │    ├── .mignore                 # files and folders for make to ignore
   │    ├── buildTheApp.m            # make-function
   │    ├── [ ... ]                  # e.g. .gitignore
   │    ├── host                     # host app:
   │    │    ├── host_app.mlapp      # 
   │    │    └── mfiles              # contains the extracted and edited code 
   │    │        └──host_app.m       # 
   │    │                            
   │    ├── firstplugin              # plugin: a standalone app byitself
   │    │    ├── bigredone.mlapp     #         into your project
   │    │    ├── [ ... ]             #
   │    │    └── mfiles              # extracted and edited classdef code 
   │    │        └── bigredone.m     # 
   │    │        └── [ ... ]         
   │    │                            
   │    ├── [ ... ]                  # the key is that you may have as much 
   │    │                            # plugins as you want 
   │    ├── popups                   
   │    │    ├── settings.mlapp      
   │    │    ├── [ ... ]             
   │    │    └── mfiles              
   │    │        └── settings.m      
   │    │        └── [ ... ]         
   │    │                            
   │    ├── functions                # both project and mlAppKit specific f(x)
   │    │    └── [ ... ]             # f(x) to parse the project files
   │    │                           
   │    └── static                   # App Designer related static assets like
   │        ├── icons                # Icons used within UI Buttons 
   │        └── [ ... ]              
   │                                 
   └── mlAppKit-docs                