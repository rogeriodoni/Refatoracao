$t = Get-Content 'C:\4c\docs\schema.sql' -Raw
$pat = '(?is)CREATE TABLE \[dbo\]\.\[SigCdOop\]\s*\((.*?)\)\s*ON'
$m = [regex]::Match($t, $pat)
if ($m.Success) {
    $m.Groups[1].Value
} else {
    "NOT FOUND"
}
