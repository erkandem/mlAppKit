
mlAppKit - Getting started
===========================

a tool to enhance your work with ``MATLAB App Designer`` (.mlapp) ease
maintenance, changes and reusing elements

--------------------------------

:Author: Erkan Demiralay – Chemical Engineer
:GitHub: `@erkandem <https://github.com/erkandem/>`_
:Email:  ed@ivsurface.com
:Web:    `erkan.io <http:/erkan.io>`_
:Twitter: @kaninchen
:Date: 06 Sept 2018






.. contents::
   :depth: 2


Executive Summary
---------------------


State of App Designer
----------------------
using MATLAB App Designer is almost as easy as working with an spreadsheets. However anyone with some experience work with spreadsheets, knows that with increasing complexity your hit a wall.


It is not different with AD.
 
#.  slows down the editor
#.  doesn't offer code folding
#.  doesn't have a visual hierarchy on the code level
#.  editable area is safe guarded
#.  favors a monolithic structure
#.  which then is hard to maintain and keep tidy and
#.  makes it more painful to introduce new features

Existing Workarounds
---------------------

Most of the issues can be simply avoided by calling an external script, function, class or application.
Functions are favorable to scripts since they offer separate  namespaces.
Classes are great to work with, if they are really necessary since they over complicate things.

Linking different apps from a central one app is I guess is the intuitive way to go. However, I would not like
to open ten different windows.

Tabs and panels offer a simple way to structure different parts of an app.
Unfortunately this structure is not reflected in the code base.
Except, if someone would use container UI elements as namespaces. 
The key to the success of this approach would be to keep the  visual  drag and drop user experience.

Is there a way to bridge the gap between programmatic and visual app design in MATLAB?

Since .mlapp files are container files the source code could be modified and zipped back.
While it sounds like a easy patch. Note that surgery is avoided for a reason.
It may work now, but the next version could break everything. [alpha]_
In other words the procedure should be noninvasive - or - at least not rely upon keeping the patient alive.


Approach presented via mlAppKit
---------------------------------
This toolkit offers relief. 

extracting code 
^^^^^^^^^^^^^^^^^^^^^^^^
.. code:: matlab

   % in courtesy of [StackOverflowMATLABchat](https://github.com/StackOverflowMATLABchat)

   evalcstr = sprintf('type(''%s‘’)’, 'app.mlapp')); % Output: 'type('app.mlapp')'
   myMcode  = evalc(evalcstr); 


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
   │    ├── .mignore                 # define files and folders to ignore during building 
   │    ├── buildTheApp.m            # make-function
   │    ├── [ ... ]                  # e.g. .gitignore
   │    ├── host                     # host app:
   │    │    ├── host_app.mlapp      # 
   │    │    └── mfiles              # contains the extracted and edited code 
   │    │        └──host_app.m       # 
   │    │                            
   │    ├── firstplugin              # plugin: a standalone app byitself to be integrated
   │    │    ├── bigredone.mlapp     #         into your project
   │    │    ├── [ ... ]             #
   │    │    └── mfiles              # extracted and edited classdef code 
   │    │        └── bigredone.m     # 
   │    │        └── [ ... ]         
   │    │                            
   │    ├── [ ... ]                  # the key is that you may have as much plugins 
   │    │                            # as you want 
   │    ├── popups                   
   │    │    ├── settings.mlapp      
   │    │    ├── [ ... ]             
   │    │    └── mfiles              
   │    │        └── settings.m      
   │    │        └── [ ... ]         
   │    │                            
   │    ├── functions                # both project and mlAppKit specific functions
   │    │    ├── building            # f(x) to parse the project files
   │    │    ├── auto_generated      # set o f f(x) created from `building`
   │    │    ├── package             # work in progress
   │    │    ├── panel_visibility    # utility
   │    │    ├── start_up            # routines cut & paste from host 
   │    │    └── [ ... ]             
   │    │                           
   │    └── static                   # App Designer related static assets like
   │        ├── icons                # Icons used within UI Buttons 
   │        └── [ ... ]              
   │                                 
   └── wonderApp-docs                

Installing 
-----------------
.. code:: bash

   mkdir yourNewPorjectFolder

.. code:: bash
   git clone 'mlAppKit'


Using
------------

Case 1: Build  a New Project
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Case 2 Migrate Existing Pieces
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Limitations
------------------------


Outlook
-------------
This is most properly an overkill, but anyway here it is.


Support, Issues, Features
------------------------------------
If you encounter issues you please check the issues section.

If you would like to propose feature go for the issues section.

materially support my work buy me a coffee.


`DuckDuckGo is your friend. Unlike Google. <https://www.duckduckggo.com>`_ 



Further Reading
------------------------------------

If you need more info please refer to the  `documentation <lol>`_
Which is also available as a `pdf <lol>`_

http://docutils.sourceforge.net/docs/ref/rst/directives.html#table-of-contents

Footnotes
-------------

.. [alpha] Some analysis on the .mlapp file format `<https://undocumentedmatlab.com/blog/appdesigner-mlapp-file-format>`_

Recent Changes
------------------

.. git_changelog::
    :revisions: 5