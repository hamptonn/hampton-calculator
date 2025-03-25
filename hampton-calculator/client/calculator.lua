lib.callback.register('hampton-calculator:showResult', function(result)
    lib.setClipboard(result)

    lib.inputDialog('Calculation Result', {
        {
            type = 'input',
            label = 'Result',
            default = result,
            disabled = true,
            icon = 'calculator'
        }
    })

    lib.notify({
        title = 'Calculator',
        description = 'Copied to clipboard!',
        type = 'success',
        icon = 'calculator'
    })

    return true
end)
print('Calculator Script - made by @hamptonn')