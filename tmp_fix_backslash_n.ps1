$files = Get-ChildItem lib\modules -Recurse -Filter *_view.dart | Where-Object { Select-String -Pattern '\\n' -Path $_.FullName -Quiet }
foreach ($file in $files) {
    $text = Get-Content -Raw -Path $file.FullName
    $text = $text -replace '\\n', [Environment]::NewLine
    $text = $text -replace '((physics: isEmbedded \? const NeverScrollableScrollPhysics\(\) : null,\r?\n\s*shrinkWrap: isEmbedded,\r?\n))+', 'physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,' + [Environment]::NewLine + '        shrinkWrap: isEmbedded,'
    Set-Content -Path $file.FullName -Value $text
    Write-Host "Fixed literal backslash-n in $($file.FullName)"
}
Write-Host 'Literal newline repair completed.'
