lib.addCommand('calc', {
    help = 'evaluate a math expression and show the result',
    params = {
        {
            name = 'expression',
            type = 'longString',
            help = 'math expression (e.g. 10 * 2 or 200x2)',
        }
    }
}, function(source, args)
    local expression = args.expression
    if not expression or expression == '' then
        lib.notify(source, {
            title = 'Calculator',
            description = 'No expression provided',
            type = 'error',
	    icon = 'calculator'
        })
        return
    end

    expression = expression:gsub('x', '*'):gsub('%s+', '')

    if expression:find('[^0-9%+%-%*/%.%(%)]+') then
        lib.notify(source, {
            title = 'Calculator',
            description = 'Invalid characters in expression',
            type = 'error',
	        icon = 'calculator'
        })
        return
    end

    local func = load('return ' .. expression)
    if not func then
        lib.notify(source, {
            title = 'Calculator',
            description = 'Invalid Expression Syntax',
            type = 'error',
            icon = 'calculator'
        })
        return
    end

    local success, result = pcall(func)
    if not success or type(result) ~= 'number' then
        lib.notify(source, {
            title = 'Calculator',
            description = 'Calculation Failed',
            type = 'error',
	        icon = 'calculator'
        })
        return
    end

    result = math.floor(result * 1000 + 0.5) / 1000
    local resultStr = tostring(result):gsub('%.0+$', ''):gsub('(%.[1-9]*)0+$', '%1')

    lib.callback.await('hampton-calculator:showResult', source, resultStr)
end)