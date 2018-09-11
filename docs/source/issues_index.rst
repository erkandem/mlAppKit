Issues, FAQ, Debugging
========================

If you come across a Bug or other issue please report it in 
the `Github Section <https://github.com/erkandem/mlAppFlex/issues>`_
Let's keep this going until Mathworks finds a way to ***** it up.

Since this file is static any reference in the issues 
section on GitHub should be checked first.
But here are some aspect which I came across:

Migration
^^^^^^^^^^^^^^^^^^^^^^^^^^

"My apps  already have  a menu" 
""""""""""""""""""""""""""""""""""""""""""""""
Three  considerations:
   
   #. Change the menu bar to an panel of buttons 
   #. make this as your new :ref:`host_app`
   #. use it as a :ref:`popup`
   

   

Errors
^^^^^^^^^^^^^^^^^^^^

"My changes are not reflected in the project files."
"""""""""""""""""""""""""""""""""""""""""""""""""""""
Flush the cache.

If you change large parts of your application in app designer, maker sure to 
clear the `mfiles` directories from the old mfiles.
This is pretty much like clearing a cache of the webserver.

This is valid for:
+ mfiles
+ HTML documentation 
+ LaTeX files


"Too many input arguments ..."
""""""""""""""""""""""""""""""""""""""""""""""""

.. code:: matlab 

   Error using `plugin` Too many input arguments.

   Error in externalStartUpFunctionOfProject (line 29)
   app.plugins.firstplugin.`plugin`      =  `plugin`(app.(f));   
   

:Reason: Somehow the folder containing a `.mlapp` file got on your filepath.
         Now, the program confuses the `classdef` file which needs an `UIFigure`
         as an input with the standalone `.mlapp` file

:Solution: Remove it from the MATLAB searchpath



Unable to find function ...""
""""""""""""""""""""""""""""""""
.. code:: matlab

   Error using `plugin`
   Unable to find function `plugin`.init.main_Panel within `path` / `plugin`.m


:Reason: the uppermost element should be an  `uipanel`.
         Also this `uipanel` has to be named `main_Panel`.
         (Not to be confused with the label of the `uipanel`)

:Solution: Remove it from the MATLAB searchpath
