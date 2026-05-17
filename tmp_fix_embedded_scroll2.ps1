$files = Get-ChildItem lib\modules -Recurse -Filter *_view.dart | Where-Object { Select-String -Pattern '\\n' -Path $_.FullName -Quiet }
foreach ($file in $files) {
    $text = Get-Content -Raw -Path $file.FullName
    $text = $text -replace 'ListView\(\\n\s*physics:', "ListView(`n        physics:"
    $text = $text -replace 'CustomScrollView\(\\n\s*physics:', "CustomScrollView(`n        physics:"
    $text = $text -replace 'GridView\.count\(\\n\s*physics:', "GridView.count(`n        physics:"
    $text = $text -replace 'GridView\.builder\(\\n\s*physics:', "GridView.builder(`n        physics:"
    $text = $text -replace 'GridView\(\\n\s*physics:', "GridView(`n        physics:"
    $text = $text -replace 'SingleChildScrollView\(\\n\s*physics:', "SingleChildScrollView(`n        physics:"
    $text = $text -replace 'physics:\s*isEmbedded\s*\?\s*const\s*NeverScrollableScrollPhysics\(\)\s*:\s*null,\s*shrinkWrap:\s*isEmbedded,\s*physics:\s*isEmbedded\s*\?\s*const\s*NeverScrollableScrollPhysics\(\)\s*:\s*null,\s*shrinkWrap:\s*isEmbedded,', "physics: isEmbedded ? const NeverScrollableScrollPhysics() : null,`n        shrinkWrap: isEmbedded,"
    Set-Content -Path $file.FullName -Value $text
    Write-Host "Fixed raw newline encoding in: $($file.FullName)"
}
Write-Host 'Fix pass completed.'
