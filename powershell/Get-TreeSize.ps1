function Get-TreeSize {
    param(
        [string]$Path = ".",
        [string]$Prefix = "",
        [bool]$IsLast = $true,
        [int]$CurrentDepth = 0,
        [int]$MaxDepth = [int]::MaxValue  # Por defecto infinito
    )

    # Si hemos alcanzado el máximo nivel de profundidad, salir
    if ($CurrentDepth -gt $MaxDepth) {
        return
    }

    # Calcula el tamaño total de esta carpeta
    $size = (Get-ChildItem -Path $Path -Recurse -File -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
    $sizeMB = $size / 1MB

    # Formatea número: punto miles, coma decimal
    $sizeFormatted = "{0:N2}" -f $sizeMB
    $sizeFormatted = $sizeFormatted -replace ',', 'TEMP' -replace '\.', ',' -replace 'TEMP', '.'

    $folderName = (Split-Path $Path -Leaf)
    if ([string]::IsNullOrEmpty($folderName)) { $folderName = (Get-Item $Path).Name }

    # Elige el conector según si es último o no
    if ($IsLast) {
        $connector = "└── "
    }
    else {
        $connector = "├── "
    }

    # Imprime la línea actual
    Write-Output "$($Prefix)$($connector)$($folderName) [$sizeFormatted MB]"

    # Si ya hemos llegado al límite de profundidad, no recursar más
    if ($CurrentDepth -eq $MaxDepth) {
        return
    }

    # Consigue subdirectorios
    $subdirs = Get-ChildItem -Path $Path -Directory -ErrorAction SilentlyContinue

    for ($i = 0; $i -lt $subdirs.Count; $i++) {
        $subdir = $subdirs[$i]
        $isLastChild = ($i -eq $subdirs.Count - 1)

        # Ajusta el prefijo para hijos
        if ($IsLast) {
            $childPrefix = "    "
        }
        else {
            $childPrefix = "│   "
        }
        $newPrefix = $Prefix + $childPrefix

        # Llamada recursiva aumentando la profundidad
        Get-TreeSize -Path $subdir.FullName -Prefix $newPrefix -IsLast:$isLastChild -CurrentDepth:($CurrentDepth + 1) -MaxDepth:$MaxDepth
    }
}

Get-TreeSize -Path "C:\projects" -MaxDepth 2

