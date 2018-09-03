.. 
    # with overline, for parts
    * with overline, for chapters
    =, for sections
    -, for subsections
    ^, for subsubsections
    “, for paragraphs
	
	

Functions
===============


Routine Summary
--------------------

Single Entry Point
^^^^^^^^^^^^^^^^^^^

buildTheApp
""""""""""""""

.. function:: buildTheApp


Core 
-----------------

The three auto functions 
^^^^^^^^^^^^^^^^^^^^^^^^^^^


addPath_creator
"""""""""""""""""""""""
.. automodule:: functions.building
.. autofunction:: addPath_creator


conversion_func_generator
""""""""""""""""""""""""""""
.. autofunction:: conversion_func_generator

mlapp_to_m
"""""""""""""
.. autofunction:: mlapp_to_m



Utilities to the auto-functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

app_launch
""""""""""""""""
.. autofunction:: app_launch

utf8_write_to_file
"""""""""""""""""""""""""""""""
.. autofunction:: utf8_write_to_file

levelOneDirQuery
"""""""""""""""""""""""""""""""
.. autofunction:: levelOneDirQuery

add_subfolder
"""""""""""""""""""""""""""""""
.. autofunction:: add_subfolder

project_parts
"""""""""""""""""""""""""""""""
.. autofunction:: project_parts

mignore_reader
"""""""""""""""""""
.. autofunction:: mignore_reader 


Connecting the different Parts
---------------------------------

Internal Dependencies
^^^^^^^^^^^^^^^^^^^^^^^

externalStartUpFunctionOfProject
""""""""""""""""""""""""""""""""""
.. automodule:: functions.start_up
.. autofunction:: externalStartUpFunctionOfProject


The Remote Controle
----------------------------

GUIs to create GUIs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

mlAppKit
"""""""""""""""""""""""""""""

.. automodule:: functions.package
.. class:: mlAppKit

to initiate the build and packaging process

mlappkit_quickstart
""""""""""""""""""""""""""""""""""
.. class:: mlappkit_quickstart

inspired by the sphinx_quickstart way of creating a boilerplate 

mlappkit_quickstart_execution
"""""""""""""""""""""""""""""""""""""""""""""
.. autofunction:: mlappkit_quickstart_execution

Not working yet.
routine which is executed. kept sepererate from the GUI file for easier access


package_app
""""""""""""""""""""""""""""""""""""""""""
.. autofunction:: package_app


plugger
""""""""""""""""""""""""""""""""""""""""""
.. autofunction:: plugger

not working yet



auto gernerated code
-------------------------------

I ran out of tilenames
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

builder_addPath
"""""""""""""""""""""""""""""""""
.. automodule:: functions.auto_generated
.. autofunction:: builder_addPath

A list of directories to add the the matlab pathdef during the **Seission**

conversion_launcher
"""""""""""""""""""""""""""""""""""""
.. autofunction:: conversion_launcher

Analyzes the project structure and
creates a scriptlike function to extract and edit the classef files 


Application Utilities
-------------------------------

Switching between Panels
^^^^^^^^^^^^^^^^^^^^^^^^

panel_visibility_switch
""""""""""""""""""""""""""""""

.. automodule:: functions.panel_visibility
.. autofunction:: panel_visibility_switch


