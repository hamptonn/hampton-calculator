AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end

    local resourcePath = LoadResourceFile(resource, 'version.txt')
    if not resourcePath or resourcePath == '' then
        print('^1[hampton-calculator]^0 [Version Checker] ❌ Could not read version.txt')
        return
    end

    local currentVersion = resourcePath:gsub('%s+', '')
    local githubURL = 'https://raw.githubusercontent.com/hamptonn/hampton-calculator/main/version.txt'

    PerformHttpRequest(githubURL, function(status, text)
        if not text or status ~= 200 then
            print('[Version Checker] Failed to check latest version. GitHub unreachable.')
            return
        end

        local latestVersion = text:gsub('%s+', '')

        if currentVersion ~= latestVersion then
            print('^1[hampton-calculator]^0 [Version Checker] ⚠️ New version available!')
            print('📌 Current: ' .. currentVersion)
            print('🆕 Latest:  ' .. latestVersion)
            print('🔗 Update: https://github.com/hamptonn/hampton-calculator')
        else
            print('^5[hampton-calculator]^0 [Version Checker] ✅ You are using the latest version (' .. currentVersion .. ')')
        end
    end, 'GET')
end)