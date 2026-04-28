#Requires AutoHotkey v2.0
#SingleInstance Off 

; --- TOMBOL DARURAT (ESC) ---
Esc:: {
    Loop 5
        Run("taskkill /F /IM Autohotkey64.exe", , "Hide")
    ExitApp()
}

global Success := ""
global FileSuara := A_ScriptDir . "\anime-ahh.mp3"

; --- MODE SPAM MSGBOX ---
if (A_Args.Length > 0 && A_Args[1] == "Spam") {
    if FileExist(FileSuara)
        SoundPlay(FileSuara)
    MsgBox(["Hahaha", "Idiot", "Corrupt"][Random(1, 3)], "System Error", 16)
    ExitApp()
}

; --- MODE JENDELA DVD (CHAOS) ---
if (A_Args.Length > 0 && A_Args[1] == "DVD") {
    Gdv := Gui("-Caption +AlwaysOnTop +ToolWindow")
    Gdv.BackColor := "Red"
    Gdv.SetFont("s20 Bold cWhite")
    Gdv.Add("Text", , "DONT CLICK ME!")
    Gdv.Show("w200 h100")
    
    vx := Random(15, 30), vy := Random(15, 30)
    x := Random(0, A_ScreenWidth-200), y := Random(0, A_ScreenHeight-100)
    
    StartTime := A_TickCount
    While (A_TickCount - StartTime < 10000) {
        x += vx, y += vy
        if (x <= 0 || x >= A_ScreenWidth-200) 
            vx *= -1, Gdv.BackColor := Random(0, 0xFFFFFF)
        if (y <= 0 || y >= A_ScreenHeight-100) 
            vy *= -1, Gdv.BackColor := Random(0, 0xFFFFFF)
        Gdv.Move(x, y)
        Sleep(10)
    }
    ExitApp()
}

; --- ALUR UTAMA ---

Upgradewin := Gui("-Caption +AlwaysOnTop", "Upgrade Windows 12")
Upgradewin.BackColor := "0078D7"
Upgradewin.SetFont("s25 cWhite Bold", "Segoe UI")
Upgradewin.Add("Text", "Center w500 y50", "Windows 12 Installation")
Upgradewin.SetFont("s12 cWhite")
Upgradewin.Add("Text", "Center w500 y150", "Upgrade your PC to the latest version of Windows.")
BtnUpgrade := Upgradewin.Add("Button", "w150 h40 x175 y250", "Upgrade Now")
BtnUpgrade.OnEvent("Click", StartDownload)
Upgradewin.Show("w500 h350")

StartDownload(*) {
    Upgradewin.Destroy()
    DL := Gui("-Caption +AlwaysOnTop", "Downloading")
    DL.BackColor := "0078D7"
    DL.SetFont("s15 cWhite", "Segoe UI")
    DL.Add("Text", "Center w400 y30", "Downloading Windows 12...")
    Prog := DL.Add("Progress", "w350 h15 x25 y80 cLime", 0)
    DL.Show("w400 h150")
    Loop 100 {
        Prog.Value += 1
        Sleep 50 
    }
    DL.Destroy()
    FaseHaha()
}

FaseHaha() {
    Haha := Gui("-Caption +AlwaysOnTop +ToolWindow +LastFound +E0x20")
    Haha.BackColor := "Black"
    WinSetTransColor("Black", Haha)
    Haha.SetFont("s100 Bold cRed", "Impact")
    Haha.Add("Text", "Center w" . A_ScreenWidth . " y" . (A_ScreenHeight/2)-100, "HAHAHA")
    Haha.Show("Maximize")
    Sleep(5000)
    Haha.Destroy()
    FaseSuccess()
}

FaseSuccess() {
    global Success
    Success := Gui("+AlwaysOnTop -SysMenu", "System Update")
    Success.SetFont("s12 Bold", "Segoe UI")
    Success.Add("Text", "Center w400", "PC kamu sudah di-upgrade, sekarang kamu bisa mencoba Windows 12.")
    BtnOk := Success.Add("Button", "w80 h30 x160 y+20", "OK")
    BtnOk.OnEvent("Click", MulaiSpamMsgBox)
    Success.Show("w400 h120")
}

MulaiSpamMsgBox(*) {
    global Success
    try Success.Destroy()
    SetTimer(PanggilMsgBox, 1000)
    SetTimer(StopSpamDanShowW12, 30000) 
}

PanggilMsgBox() {
    Run(A_AhkPath . ' "' . A_ScriptFullPath . '" Spam')
}

StopSpamDanShowW12() {
    SetTimer(PanggilMsgBox, 0)
    SetTimer(StopSpamDanShowW12, 0)
    
    global Win12 := Gui("-Caption +AlwaysOnTop", "Windows 12 Desktop")
    Win12.BackColor := "004a99"
    
    ; FIX: Gunakan Menu yang dipicu klik kanan
    global MyMenu := Menu()
    MyMenu.Add("Refresh", (*) => MsgBox("Desktop Refreshed"))
    MyMenu.Add("DONT CLICK ME", StartDVDChaos)
    
    ; Event ContextMenu untuk handle klik kanan
    Win12.OnEvent("ContextMenu", (*) => MyMenu.Show())
    
    ; Taskbar
    Win12.Add("Text", "x0 y" . (A_ScreenHeight-60) . " w" . A_ScreenWidth . " h60 Background222222", "")
    
    ; Icon Downgrade di Kiri
    Win12.SetFont("s10 cWhite Bold")
    BtnDG := Win12.Add("Button", "x20 y40 w80 h40", "Downgrade")
    BtnDG.OnEvent("Click", ProsesDowngrade)
    
    Win12.Show("Maximize")
}

StartDVDChaos(*) {
    Loop 5
        Run(A_AhkPath . ' "' . A_ScriptFullPath . '" DVD')
}

ProsesDowngrade(*) {
    Win12.Destroy()
    DG := Gui("-Caption +AlwaysOnTop", "Downgrading")
    DG.BackColor := "0078D7"
    DG.SetFont("s15 cWhite", "Segoe UI")
    DG.Add("Text", "Center w400 y30", "Processing Downgrade...")
    ProgDG := DG.Add("Progress", "w350 h15 x25 y80 cLime", 0)
    DG.Show("w400 h150")
    
    Loop 100 {
        ProgDG.Value += 1
        Sleep 50 
    }
    
    DG.Destroy()
    ; BERSIHKAN TOTAL SEMUA MSGBOX DAN DVD
    Loop 10
        Run("taskkill /F /IM Autohotkey64.exe", , "Hide")
    MsgBox("Selesai! Desktop sudah bersih.", "Windows 10", 64)
    ExitApp()
}