
$files = Get-ChildItem -Path lib -Filter *.dart -Recurse | Where-Object { $_.FullName -notmatch "\.g\.dart$" }

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    
    # Updated pattern to handle multiple parameters
    # Matches: @riverpod then optionally some space/newline then the function signature
    # Group 1: Prefix up to the open paren
    # Group 2: Function name
    # Group 3: Optional space after Ref ref
    # Group 4: Remaining parameters if any
    $pattern = '@riverpod\s*\r?\n(\s*\w+\s+(\w+)\()Ref\s+ref\s*(,)?'
    
    $newContent = [regex]::Replace($content, $pattern, {
        param($match)
        $prefix = $match.Groups[1].Value
        $funcName = $match.Groups[2].Value
        $comma = $match.Groups[3].Value
        
        # Convert first letter of funcName to uppercase
        $pascalName = $funcName.Substring(0,1).ToUpper() + $funcName.Substring(1)
        $refType = "${pascalName}Ref"
        
        $replacement = "@riverpod`n${prefix}${refType} ref"
        if ($comma) {
            $replacement += ","
        }
        return $replacement
    })
    
    if ($content -ne $newContent) {
        Write-Host "Updating $($file.FullName)"
        $newContent | Set-Content $file.FullName -NoNewline
    }
}
