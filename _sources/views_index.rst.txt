Examples
===================

Built in  Example
------------------
The git  project comes with a basic but nontheless working example
consisting of:

#. documentation sample
#. host application 
#. pop-up views
#. one group of plugin views


Structuring your own documentation on the go
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


here is an example on how easy it to include basic documentation
and basic comments into a MATLAB project:
::
	
	firstClassDef
	----------------
	.. automodule:: firstfolder.secondfolder_seperated_by_a_dot
	.. autoclass:: final_class_file_without_file_ending
		:members:
		:show-inheritance:
		:undoc-members:
		
	the next classdef
	----------------
	
For more details see the spinx documentation or take a look in the appendix


Host Application
^^^^^^^^^^^^^^^^^^

For a more general introduction you may want to look at the getting started or readme part.
Apart from some naming conventions, declare but uninitialized properties, a startup function
and callbacks for the navigation menu there is nothing special about the  file

Except that:

1. it is located in the `host` folder within the project root folder
2. and that their may only be one host

Of course, you could chain up multiple `classdef` files in a series.
But I did not go to far into that

.. automodule:: host.mfiles
.. autoclass:: host_app
    :members:
    :show-inheritance:


Plugin Views
^^^^^^^^^^^^^^^^^^
You may create any amount of plugin  views, which may have multiple other plugins
That is exactly the idea. For example create a file selection/navigation app strip it off
of its  `UIfigure` and load it into a plugin view

I would recommend changing the content of the existing samples:

redbutton
""""""""""""""""""

.. automodule:: firstplugin.mfiles
.. autoclass:: redbutton
    :members:
    :show-inheritance:
    :undoc-members:
    
    
calculator
"""""""""""""""""
.. autoclass:: calculator
    :members:
    :show-inheritance:
    :undoc-members:



Popup Views
^^^^^^^^^^^^^^^^^^
PopUps are essential to save real estate or introducing 
new features which are not yet fully integrated into the GUI.

Example usages would be  options, license details, update checks.
I included two samples :class:`popup_about` and :class:`popup_settings` 

popup_about
"""""""""""""""""""""""
.. automodule:: popups.mfiles
.. autoclass:: popup_about
    :members:
    :show-inheritance:
    :undoc-members:


settings
"""""""""""""""""""""""

.. autoclass:: popup_settings
    :members:
    :show-inheritance:
    :undoc-members:
