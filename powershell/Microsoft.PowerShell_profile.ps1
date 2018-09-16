

function Run-At {
	param(
		[ScriptBlock] $Command,
		[string] $ComputerName,
		[int] $Port = 22
	)

	$res = $Command.ToString().Split("`n") | ? {$_ -ne ""} 
	$cmd = [string]::Join("; ", $res)
	ssh -p $Port $ComputerName pwsh -Command $cmd
}

import-module posh-git

function Prompt {
	Write-Host -NoNewLine ((get-date).ToString("hh:MM:ss"))
	Write-Host -NoNewLine " | "
	Write-Host -NoNewLine (hostname)
	Write-Host -NoNewLine " "
	write-host -NoNewLine -ForegroundColor green ($PWD.ToString().Split("/")[-1])
	Write-Host -NoNewLine " "
	if ((Get-GitStatus) -ne $null) 
	{
		Write-Host -NoNewLine (Get-GitStatus).Branch
		Write-Host -NoNewLine " "
	}
}

enum Display {
	HDMI
	VGA
	LVDS
}

function Set-Displpay {
	
	[CmdletBinding()]
	param(
		[Parameter(Mandatory)]
		[Display] $Display,
		[switch] $AdjustBackground
	)
	switch ($Display) 
	{
		HDMI 
		{
			xrandr --output LVDS1 --auto --output HDMI1 --same-as LVDS1
			xrandr --output HDMI1 --mode 1920x1080
		}
		VGA 
		{
			xrandr --output VGA1 --auto --output HDMI1 --auto
		}
		LVDS 
		{
			xrandr --output LVDS1 --auto --output HDMI1 --auto
		}
	}
	if ($AdjustBackground) 
	{
		feh --bg-scale Desktop/bg.jpg
	}
}

function Get-Displays 
{
	(xrandr --listmonitors | % {$_.Split(" ")[-1]} ) | Select-Object -Skip 1 
}

function LSLS {gci @args | Format-Table -Property Mode,Name}
function Get-Ip {
	param(
		[switch] $Public
	)
	if ($Public) {
		(Invoke-RestMethod jsonip.com).ip
	}
	else 
	{
		[System.Net.Dns]::GetHostEntry([System.Net.Dns]::GetHostName()).AddressList | Select-Object IpAddressToString
	}
}

function Get-BatteryInfo 
{
	gci /sys/class/power_supply/ | ? {$_ -match "BAT"} | % {@{
		battery = $_
		level = (gc ($_.FullName + "/capacity")) + "%"
		status = (gc ($_.FullName + "/status"))
	}} 
}

Set-Alias ls LSLS
