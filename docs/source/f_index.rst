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
-------------------------
buildTheApp
""""""""""""""

.. autofunction:: buildTheApp


Core 
-----------------
The three auto function 
^^^^^^^^^^^^^^^^^^^^^^^^^^^^


addPath_creator
"""""""""""""""""""""""

.. automodule:: functions.building
.. autofunction:: addPath_creator


conversion_func_generator
""""""""""""""""""""""""""""
.. autofunction:: conversion_func_generator


mlapp_to_m
"""""""""""""""""""""""""""""""
.. autofunction:: mlapp_to_m



Utilities to the auto-functions^
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. autofunction:: app_launch

.. autofunction:: utf8_write_to_file

.. autofunction:: levelOneDirQuery

.. autofunction:: add_subfolder

.. autofunction:: project_parts



Connecting parts 
-------------------------

externalStartUpFunctionOfProject
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. automodule:: functions.start_up
.. autofunction:: externalStartUpFunctionOfProject


The Remote Controle
----------------------------

.. automodule:: functions.package

.. class:: mlAppKit

GUI, to initiate the build and packaging process

.. class:: mlappkit_quickstart

inspired by the sphinx_quickstart way of creating a boilerplate 

.. autofunction:: mlappkit_quickstart_execution

Not working yet.
routine which is executed. kept sepererate from the GUI file for easier access


package_app
""""""""""""""""""""""""""""""""""""""""""

.. :autofunction:: package_app


plugger
""""""""""""""""""""""""""""""""""""""""""
.. autofunction:: plugger

not working yet



automatically created functions
-------------------------------
.. automodule:: functions.auto_generated
.. autofunction:: builder_addPath

A list of directories to add the the matlab pathdef during the **Seission**


.. autofunction:: conversion_launcher


Analyzes the project structure and
areates a scriptlike function to extract and edit the classef files 


