classdef calculator < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
%        UIFigure         matlab.ui.Figure
        main_Panel       matlab.ui.container.Panel
        CalculatorPanel  matlab.ui.container.Panel
        dial_seven       matlab.ui.control.Button
        dial_eight       matlab.ui.control.Button
        dial_nine        matlab.ui.control.Button
        dial_four        matlab.ui.control.Button
        dial_five        matlab.ui.control.Button
        dial_six         matlab.ui.control.Button
        dial_one         matlab.ui.control.Button
        dial_two         matlab.ui.control.Button
        dial_three       matlab.ui.control.Button
        dial_zero        matlab.ui.control.Button
        dial_decimal     matlab.ui.control.Button
        dial_div         matlab.ui.control.Button
        dial_sub         matlab.ui.control.Button
        dial_mult        matlab.ui.control.Button
        dial_equal       matlab.ui.control.Button
        dial_add         matlab.ui.control.Button
        screenField      matlab.ui.control.TextArea
        CButton          matlab.ui.control.Button
    end

    
    methods (Access = private)
        
        function dial_button_pushed(app, value)
            % executed when a number button is pushed
            % convert to char and append to list
            if isa(value, 'char')
                if  strcmp(value,'.')
                    if isempty(app.screenField.Value ) &&  ismember(app.screenField.Value(end),{'+';'-';'/';'*'})
                        app.screenField.Value = {sprintf('0%s', value)};     
                    elseif isempty(app.screenField.Value ) &&  ~ismember(app.screenField.Value(end),{'+';'-';'/';'*'})
                        app.screenField.Value = [app.screenField.Value{1},...
                                                {sprintf('%s', value)}];    
                    end
                else
                    if strcmp(value ,'=')
                        eval_calc(app);
                    else
                        calc_operator_pushed(app, value);
                    end
                end
            elseif isa(value, 'double')
                if isempty (app.screenField.Value{1} ) 
                    app.screenField.Value = {sprintf('%d', value)};
                else 
                    if ismember(app.screenField.Value{end}(end),{'+';'-';'/';'*'}) && size(app.screenField.Value,1)>1  % newline without any character
                        app.screenField.Value = [app.screenField.Value ;
                                                { sprintf('%d', value)}];
                    elseif ~ismember(app.screenField.Value{end}(end),{'+';'-';'/';'*'}) && size(app.screenField.Value,1)>1
                         app.screenField.Value(end) =  { [app.screenField.Value{end}, sprintf('%d', value)]};
                    elseif ~ismember(app.screenField.Value(end),{'+';'-';'/';'*'}) && ~(size(app.screenField.Value,1)>1)
                         app.screenField.Value = { [app.screenField.Value{end}, sprintf('%d', value)]};
                    end
                end
            end
        end
        
        function  calc_operator_pushed(app,value )
        
            if ~isempty(app.screenField.Value )
                if ~ismember(app.screenField.Value(end),{'+';'-';'/';'*'})
                    cV = app.screenField.Value ;
                  %  app.screenField.Value = [cV; {[repmat(' ',1 , max(cellfun(@numel,cV)*2 )-1), value]} ];
                     app.screenField.Value = [cV; value];
                else
                            app.screenField.Value(end) = {value} ;
                end
            end

        end
        
        function eval_calc(app)
               
            if size(app.screenField.Value,1 ) == 3
                para_first  = app.screenField.Value{1};
                para_second = app.screenField.Value{end};
                operator    = app.screenField.Value{2};
            elseif  size(app.screenField.Value,1 ) == 2
                para_first  = app.screenField.Value{1};
                para_second = para_first;
                operator    = app.screenField.Value{2};
            
            elseif  size(app.screenField.Value,1) == 1
                return
            end
           
            switch operator
                case {'+'}
                     sol= str2double(para_first) + str2double(para_second); 
                case {'-'}
                     sol= str2double(para_furst) - str2double(para_second); 
                case {'/'}
                     sol= str2double(para_first) / str2double(para_second); 
                case {'*'}
                     sol= str2double(para_first) * str2double(para_second); 
            end
            app.screenField.Value = {sprintf('%.5f' , sol) };    
        end
    end


    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            
        end

        % Button pushed function: dial_one
        function dial_oneButtonPushed(app, event)
            dial_button_pushed(app, 1);
        end

        % Button pushed function: dial_two
        function dial_twoButtonPushed(app, event)
            dial_button_pushed(app, 2);
        end

        % Button pushed function: dial_three
        function dial_threeButtonPushed(app, event)
            dial_button_pushed(app, 3);
        end

        % Button pushed function: dial_four
        function dial_fourButtonPushed(app, event)
            dial_button_pushed(app, 4);
        end

        % Button pushed function: dial_five
        function dial_fiveButtonPushed(app, event)
            dial_button_pushed(app, 5);
        end

        % Button pushed function: dial_six
        function dial_sixButtonPushed(app, event)
            dial_button_pushed(app, 6);
        end

        % Button pushed function: dial_seven
        function dial_sevenButtonPushed(app, event)
            dial_button_pushed(app, 7);
        end

        % Button pushed function: dial_eight
        function dial_eightButtonPushed(app, event)
            dial_button_pushed(app, 8);
        end

        % Button pushed function: dial_nine
        function dial_nineButtonPushed(app, event)
            dial_button_pushed(app, 9);
        end

        % Button pushed function: dial_add
        function dial_addButtonPushed(app, event)
            dial_button_pushed(app, '+');
        end

        % Button pushed function: dial_sub
        function dial_subButtonPushed(app, event)
            dial_button_pushed(app, '-');
        end

        % Button pushed function: dial_mult
        function dial_multButtonPushed(app, event)
            dial_button_pushed(app, '*');
        end

        % Button pushed function: dial_div
        function dial_divButtonPushed(app, event)
            dial_button_pushed(app, '/');
        end

        % Button pushed function: dial_equal
        function dial_equalButtonPushed(app, event)
            dial_button_pushed(app, '=');
        end

        % Button pushed function: dial_decimal
        function dial_decimalButtonPushed(app, event)
                dial_button_pushed(app, '.');
        end

        % Button pushed function: CButton
        function CButtonPushed(app, event)
            app.screenField.Value ={''};
        end

        % Button pushed function: dial_zero
        function dial_zeroButtonPushed(app, event)
        dial_button_pushed(app, 0);

        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function  createComponents(app,external_handle) % $_$ flipped 

            % Create UIFigure and hide until all components are created
%            app.UIFigure = uifigure('Visible', 'off');
%            app.UIFigure.Position = [100 100 1024 640];
%            app.UIFigure.Name = 'UI Figure';

            % Create main_Panel
            app.main_Panel = uipanel(external_handle);
            app.main_Panel.Title = 'Panel';
            app.main_Panel.Position = [1 1 1024 640];

            % Create CalculatorPanel
            app.CalculatorPanel = uipanel(app.main_Panel);
            app.CalculatorPanel.Title = 'Calculator';
            app.CalculatorPanel.Position = [368 176 251 320];

            % Create dial_seven
            app.dial_seven = uibutton(app.CalculatorPanel, 'push');
            app.dial_seven.ButtonPushedFcn = createCallbackFcn(app, @dial_sevenButtonPushed, true);
            app.dial_seven.Position = [29 170 42 30];
            app.dial_seven.Text = '7';

            % Create dial_eight
            app.dial_eight = uibutton(app.CalculatorPanel, 'push');
            app.dial_eight.ButtonPushedFcn = createCallbackFcn(app, @dial_eightButtonPushed, true);
            app.dial_eight.Position = [81 170 42 30];
            app.dial_eight.Text = '8';

            % Create dial_nine
            app.dial_nine = uibutton(app.CalculatorPanel, 'push');
            app.dial_nine.ButtonPushedFcn = createCallbackFcn(app, @dial_nineButtonPushed, true);
            app.dial_nine.Position = [131 170 42 30];
            app.dial_nine.Text = '9';

            % Create dial_four
            app.dial_four = uibutton(app.CalculatorPanel, 'push');
            app.dial_four.ButtonPushedFcn = createCallbackFcn(app, @dial_fourButtonPushed, true);
            app.dial_four.Position = [29 130 42 30];
            app.dial_four.Text = '4';

            % Create dial_five
            app.dial_five = uibutton(app.CalculatorPanel, 'push');
            app.dial_five.ButtonPushedFcn = createCallbackFcn(app, @dial_fiveButtonPushed, true);
            app.dial_five.Position = [81 130 42 30];
            app.dial_five.Text = '5';

            % Create dial_six
            app.dial_six = uibutton(app.CalculatorPanel, 'push');
            app.dial_six.ButtonPushedFcn = createCallbackFcn(app, @dial_sixButtonPushed, true);
            app.dial_six.Position = [131 130 42 30];
            app.dial_six.Text = '6';

            % Create dial_one
            app.dial_one = uibutton(app.CalculatorPanel, 'push');
            app.dial_one.ButtonPushedFcn = createCallbackFcn(app, @dial_oneButtonPushed, true);
            app.dial_one.Position = [29 90 42 30];
            app.dial_one.Text = '1';

            % Create dial_two
            app.dial_two = uibutton(app.CalculatorPanel, 'push');
            app.dial_two.ButtonPushedFcn = createCallbackFcn(app, @dial_twoButtonPushed, true);
            app.dial_two.Position = [81 90 42 30];
            app.dial_two.Text = '2';

            % Create dial_three
            app.dial_three = uibutton(app.CalculatorPanel, 'push');
            app.dial_three.ButtonPushedFcn = createCallbackFcn(app, @dial_threeButtonPushed, true);
            app.dial_three.Position = [129 90 42 30];
            app.dial_three.Text = '3';

            % Create dial_zero
            app.dial_zero = uibutton(app.CalculatorPanel, 'push');
            app.dial_zero.ButtonPushedFcn = createCallbackFcn(app, @dial_zeroButtonPushed, true);
            app.dial_zero.Position = [31 50 42 30];
            app.dial_zero.Text = '0';

            % Create dial_decimal
            app.dial_decimal = uibutton(app.CalculatorPanel, 'push');
            app.dial_decimal.ButtonPushedFcn = createCallbackFcn(app, @dial_decimalButtonPushed, true);
            app.dial_decimal.Position = [81 50 42 30];
            app.dial_decimal.Text = '.';

            % Create dial_div
            app.dial_div = uibutton(app.CalculatorPanel, 'push');
            app.dial_div.ButtonPushedFcn = createCallbackFcn(app, @dial_divButtonPushed, true);
            app.dial_div.Position = [191 170 42 30];
            app.dial_div.Text = '/';

            % Create dial_sub
            app.dial_sub = uibutton(app.CalculatorPanel, 'push');
            app.dial_sub.ButtonPushedFcn = createCallbackFcn(app, @dial_subButtonPushed, true);
            app.dial_sub.Position = [191 90 42 30];
            app.dial_sub.Text = '-';

            % Create dial_mult
            app.dial_mult = uibutton(app.CalculatorPanel, 'push');
            app.dial_mult.ButtonPushedFcn = createCallbackFcn(app, @dial_multButtonPushed, true);
            app.dial_mult.Position = [191 130 42 30];
            app.dial_mult.Text = '*';

            % Create dial_equal
            app.dial_equal = uibutton(app.CalculatorPanel, 'push');
            app.dial_equal.ButtonPushedFcn = createCallbackFcn(app, @dial_equalButtonPushed, true);
            app.dial_equal.Position = [191 10 42 30];
            app.dial_equal.Text = '=';

            % Create dial_add
            app.dial_add = uibutton(app.CalculatorPanel, 'push');
            app.dial_add.ButtonPushedFcn = createCallbackFcn(app, @dial_addButtonPushed, true);
            app.dial_add.Position = [190 50 42 30];
            app.dial_add.Text = '+';

            % Create screenField
            app.screenField = uitextarea(app.CalculatorPanel);
            app.screenField.HorizontalAlignment = 'right';
            app.screenField.Position = [30 220 151 60];

            % Create CButton
            app.CButton = uibutton(app.CalculatorPanel, 'push');
            app.CButton.ButtonPushedFcn = createCallbackFcn(app, @CButtonPushed, true);
            app.CButton.Position = [191 230 48 40];
            app.CButton.Text = 'C';

            % Show the figure after all components are created
%            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
            function app = calculator(external_handle) % $_$ flipped 

            % Create UIFigure and components
             createComponents(app,external_handle) % $_$ flipped 

            % Register the app with App Designer
%            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
%            delete(app.UIFigure)
        end
    end
end

