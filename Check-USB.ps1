function Show-MsgBoxCountDown
{
    [reflection.assembly]::loadwithpartialname("System.Windows.Forms") | Out-Null
    [reflection.assembly]::loadwithpartialname("System.Drawing") | Out-Null

    $form = New-Object System.Windows.Forms.Form
    $label = New-Object System.Windows.Forms.Label
    $label1 = New-Object System.Windows.Forms.Label
    $progressBar = New-Object System.Windows.Forms.ProgressBar
    $timer = New-Object System.Windows.Forms.Timer
    $InitialFormWindowState = New-Object System.Windows.Forms.FormWindowState

    $timer_OnTick =
    {
        $progressBar.PerformStep()
        $time = 60 - $progressBar.Value
        [char[]]$mins = "{0}" -f ($time / 60)
        $secs = "{0:00}" -f ($time % 60)
        $label1.Text = "{0}:{1}" -f $mins[0], $secs
        
        if($progressBar.Value -lt 60) {$null}
        else
        {
            $timer.Enabled = $false
            $form.dispose()
        }
    }

    $form.WindowState = $InitialFormWindowState

    $form.MaximumSize = New-Object System.Drawing.Size(500,250)
    $form.Text = 'Check-USB'
    $form.BackColor = "#cc5500"
    $form.ControlBox = $false
    $form.ShowIcon = $False
    $form.MinimumSize = New-Object System.Drawing.Size(500,250)
    $form.StartPosition = 1
    $form.DataBindings.DefaultDataSourceUpdateMode = 0
    $form.ClientSize = New-Object System.Drawing.Size(500,250)

    $label.TabIndex = 3
    $label.TextAlign = 32
    $label.Size = New-Object System.Drawing.Size(480,120)
    $label.Text = "Don't forget your USB Flash Drive!"
    $label.Font = New-Object System.Drawing.Font("Courier New",14.25,1,3,0)
    $label.BackColor = "#cc5500"
    $label.ForeColor = [System.Drawing.Color]::White
    $label.Location = New-Object System.Drawing.Point(1,51) 
    $label.DataBindings.DefaultDataSourceUpdateMode = 0

    $form.Controls.Add($label)

    $label1.TabIndex = 3
    $label1.TextAlign = 32
    $label1.Size = New-Object System.Drawing.Size(100,42)
    $label1.Text = '0:60'
    $label1.Font = New-Object System.Drawing.Font("Courier New",20.25,1,3,0)
    $label1.BackColor = "#cc5500"
    $label1.ForeColor = [System.Drawing.Color]::White
    $label1.Location = New-Object System.Drawing.Point(190,11)
    $label1.DataBindings.DefaultDataSourceUpdateMode = 0

    $form.Controls.Add($label1)

    $progressBar.Step = 1
    $progressBar.visible = $false

    $form.Controls.Add($progressBar)

    $timer.Enabled = $true
    $timer.Start()
    $timer.Interval = 1000
    $timer.add_tick($timer_OnTick)

    $InitialFormWindowState = $form.WindowState
    $form.add_Load($form.WindowsState)
    $form.ShowDialog()| Out-Null

} # END function Show-MsgBoxCountDown



function Check-USB
{
    # Check for a USB, Get UserName and ComputerName from env variables
    $USB_Detected = Get-WmiObject -Class Win32_LogicalDisk | Where-Object {($_.DriveType -eq 2) -and ($_.DeviceID -ne "A:")}

    if($USB_Detected)
    {
        Show-MsgBoxCountDown
    }
    else
    {
        $null
    }
    
} # END function Check-USB

# Call the function
Check-USB