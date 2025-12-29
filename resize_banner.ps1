Add-Type -AssemblyName System.Drawing

$sourcePath = "C:\Users\Afroculture\.gemini\antigravity\brain\9276f7ee-77d0-441d-8d66-1ffa0e13b1a3\uploaded_image_1766845122777.png"
$destPath = "c:\fluuter_p\mytvs\android\app\src\main\res\drawable-xhdpi\tv_banner.png"
$width = 320
$height = 180

$srcImage = [System.Drawing.Image]::FromFile($sourcePath)
$newImage = new-object System.Drawing.Bitmap $width, $height

$graphics = [System.Drawing.Graphics]::FromImage($newImage)
$graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
$graphics.DrawImage($srcImage, 0, 0, $width, $height)
$graphics.Dispose()

$newImage.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
$newImage.Dispose()
$srcImage.Dispose()

Write-Host "Image resized and saved to $destPath"
