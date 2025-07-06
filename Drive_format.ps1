Clear-Host

# ##New Attached Disk Details
do {
    $RawDisk = Get-Disk | Where-Object { $_.PartitionStyle -eq 'RAW' }

    if (-not $RawDisk) {
        Write-Host "Waiting for a new RAW disk to be added..." -ForegroundColor Yellow
        Start-Sleep -Seconds 5
    }
} while (-not $RawDisk)

Write-Host "Below are the new disk details" -ForegroundColor Yellow
$RawDisk | Select-Object DiskNumber, PartitionStyle, HealthStatus, IsBoot, Size | Sort-Object DiskNumber | Format-Table -AutoSize

# Prompt user to enter disk number
$Number = Read-Host "Enter the disk number to be formatted and assign new drive letter"

# Initialize disk with GPT format
Initialize-Disk -Number $Number -PartitionStyle GPT


$unitSize= Read-Host "Enter the Allocationunitsize(65536(64kb)/4096bytes):"
# New partition and format disk with new drive letter
$Format_Disk = New-Partition -DiskNumber $Number -UseMaximumSize -AssignDriveLetter | 
                    Format-Volume -FileSystem NTFS -AllocationUnitSize $unitSize -Confirm:$false

Write-Host "Total disk in server currently::" -ForegroundColor Green
#Disk_Details
Get-Volume |Select-Object DriveLetter,OperationalStatus,HealthStatus,FileSystemType,AllocationUnitSize,Size,SizeRemaining |Sort-Object DriveLetter|Format-Table -AutoSize
