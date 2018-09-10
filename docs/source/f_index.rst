.. 
    # with overline, for parts
    * with overline, for chapters
    =, for sections
    -, for subsections
    ^, for subsubsections
    “, for paragraphs
	
	

Functions
===============


Connecting the Host with Plugins and Pop Ups
---------------------------------------------

Internal Dependencies
^^^^^^^^^^^^^^^^^^^^^^^

externalStartUpFunctionOfProject
""""""""""""""""""""""""""""""""""
.. automodule:: functions.start_up
.. autofunction:: externalStartUpFunctionOfProject



Core 
-----------------

The Three Core Functions 
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


Utilities to the Automatically Created Functions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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



The GUI to Develope GUIs
----------------------------------------

GUIs to create GUIs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
.. warning:: This part is in development


mlAppKit
"""""""""""""""""""""""""""""

.. automodule:: functions.package
.. class:: mlAppKit

to initiate the build and packaging process

mlappkit_quickstart
""""""""""""""""""""""""""""""""""
.. class:: mlappkit_quickstart

inspired by the sphinx_quickstart way of creating a boilerplate 
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

Switching Between Panels
^^^^^^^^^^^^^^^^^^^^^^^^

panel_visibility_switch
""""""""""""""""""""""""""""""

.. automodule:: functions.panel_visibility
.. autofunction:: panel_visibility_switch


The final step
--------------------

Building the App 
^^^^^^^^^^^^^^^^^^^

make
""""""""""""""

.. function:: make