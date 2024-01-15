require 'lib.moonloader'

script_name("wraith-tactical")
script_author("qrlk")
script_description("wraith tactical")
-- made for https://www.blast.hk/threads/193650/
script_url("https://github.com/qrlk/wraith-tactical")
script_version("15.01.2024-dev")

-- https://github.com/qrlk/qrlk.lua.moonloader
local enable_sentry = true     -- false to disable error reports to sentry.io
-- https://github.com/qrlk/moonloader-script-updater
local enable_autoupdate = true -- false to disable auto-update + disable sending initial telemetry (server, moonloader version, script version, samp nickname, virtual volume serial number)

--^^ none of it works if wraith-tactical is loaded as a module.

-- https://github.com/qrlk/qrlk.lua.moonloader
if enable_sentry then
    local sentry_loaded, Sentry = pcall(loadstring,
        [=[return {init=function(a)local b,c,d=string.match(a.dsn,"https://(.+)@(.+)/(%d+)")local e=string.format("https://%s/api/%d/store/?sentry_key=%s&sentry_version=7&sentry_data=",c,d,b)local f=string.format("local target_id = %d local target_name = \"%s\" local target_path = \"%s\" local sentry_url = \"%s\"\n",thisScript().id,thisScript().name,thisScript().path:gsub("\\","\\\\"),e)..[[require"lib.moonloader"script_name("sentry-error-reporter-for: "..target_name.." (ID: "..target_id..")")script_description("���� ������ ������������� ������ ������� '"..target_name.." (ID: "..target_id..")".."' � ���������� �� � ������� ����������� ������ Sentry.")local a=require"encoding"a.default="CP1251"local b=a.UTF8;local c="moonloader"function getVolumeSerial()local d=require"ffi"d.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local e=d.new("unsigned long[1]",0)d.C.GetVolumeInformationA(nil,nil,0,e,nil,nil,nil,0)e=e[0]return e end;function getNick()local f,g=pcall(function()local f,h=sampGetPlayerIdByCharHandle(PLAYER_PED)return sampGetPlayerNickname(h)end)if f then return g else return"unknown"end end;function getRealPath(i)if doesFileExist(i)then return i end;local j=-1;local k=getWorkingDirectory()while j*-1~=string.len(i)+1 do local l=string.sub(i,0,j)local m,n=string.find(string.sub(k,-string.len(l),-1),l)if m and n then return k:sub(0,-1*(m+string.len(l)))..i end;j=j-1 end;return i end;function url_encode(o)if o then o=o:gsub("\n","\r\n")o=o:gsub("([^%w %-%_%.%~])",function(p)return("%%%02X"):format(string.byte(p))end)o=o:gsub(" ","+")end;return o end;function parseType(q)local r=q:match("([^\n]*)\n?")local s=r:match("^.+:%d+: (.+)")return s or"Exception"end;function parseStacktrace(q)local t={frames={}}local u={}for v in q:gmatch("([^\n]*)\n?")do local w,x=v:match("^	*(.:.-):(%d+):")if not w then w,x=v:match("^	*%.%.%.(.-):(%d+):")if w then w=getRealPath(w)end end;if w and x then x=tonumber(x)local y={in_app=target_path==w,abs_path=w,filename=w:match("^.+\\(.+)$"),lineno=x}if x~=0 then y["pre_context"]={fileLine(w,x-3),fileLine(w,x-2),fileLine(w,x-1)}y["context_line"]=fileLine(w,x)y["post_context"]={fileLine(w,x+1),fileLine(w,x+2),fileLine(w,x+3)}end;local z=v:match("in function '(.-)'")if z then y["function"]=z else local A,B=v:match("in function <%.* *(.-):(%d+)>")if A and B then y["function"]=fileLine(getRealPath(A),B)else if#u==0 then y["function"]=q:match("%[C%]: in function '(.-)'\n")end end end;table.insert(u,y)end end;for j=#u,1,-1 do table.insert(t.frames,u[j])end;if#t.frames==0 then return nil end;return t end;function fileLine(C,D)D=tonumber(D)if doesFileExist(C)then local E=0;for v in io.lines(C)do E=E+1;if E==D then return v end end;return nil else return C..D end end;function onSystemMessage(q,type,i)if i and type==3 and i.id==target_id and i.name==target_name and i.path==target_path and not q:find("Script died due to an error.")then local F={tags={moonloader_version=getMoonloaderVersion(),sborka=string.match(getGameDirectory(),".+\\(.-)$")},level="error",exception={values={{type=parseType(q),value=q,mechanism={type="generic",handled=false},stacktrace=parseStacktrace(q)}}},environment="production",logger=c.." (no sampfuncs)",release=i.name.."@"..i.version,extra={uptime=os.clock()},user={id=getVolumeSerial()},sdk={name="qrlk.lua.moonloader",version="0.0.0"}}if isSampAvailable()and isSampfuncsLoaded()then F.logger=c;F.user.username=getNick().."@"..sampGetCurrentServerAddress()F.tags.game_state=sampGetGamestate()F.tags.server=sampGetCurrentServerAddress()F.tags.server_name=sampGetCurrentServerName()else end;print(downloadUrlToFile(sentry_url..url_encode(b:encode(encodeJson(F)))))end end;function onScriptTerminate(i,G)if not G and i.id==target_id then lua_thread.create(function()print("������ "..target_name.." (ID: "..target_id..")".."�������� ���� ������, ����������� ����� 60 ������")wait(60000)thisScript():unload()end)end end]]local g=os.tmpname()local h=io.open(g,"w+")h:write(f)h:close()script.load(g)os.remove(g)end}]=])
    if sentry_loaded and Sentry then
        pcall(Sentry().init, {
            dsn = "https://694c89af9e39fc45c7766fa16738c6d7@o1272228.ingest.sentry.io/4506574243168256"
        })
    end
end

-- https://github.com/qrlk/moonloader-script-updater
local autoupdate_loaded = false
local Update = nil
if enable_autoupdate then
    local updater_loaded, Updater = pcall(loadstring,
        [[return {check=function (a,b,c) local d=require('moonloader').download_status;local e=os.tmpname()local f=os.clock()if doesFileExist(e)then os.remove(e)end;downloadUrlToFile(a,e,function(g,h,i,j)if h==d.STATUSEX_ENDDOWNLOAD then if doesFileExist(e)then local k=io.open(e,'r')if k then local l=decodeJson(k:read('*a'))updatelink=l.updateurl;updateversion=l.latest;k:close()os.remove(e)if updateversion~=thisScript().version then lua_thread.create(function(b)local d=require('moonloader').download_status;local m=-1;sampAddChatMessage(b..'���������� ����������. ������� ���������� c '..thisScript().version..' �� '..updateversion,m)wait(250)downloadUrlToFile(updatelink,thisScript().path,function(n,o,p,q)if o==d.STATUS_DOWNLOADINGDATA then print(string.format('��������� %d �� %d.',p,q))elseif o==d.STATUS_ENDDOWNLOADDATA then print('�������� ���������� ���������.')sampAddChatMessage(b..'���������� ���������!',m)goupdatestatus=true;lua_thread.create(function()wait(500)thisScript():reload()end)end;if o==d.STATUSEX_ENDDOWNLOAD then if goupdatestatus==nil then sampAddChatMessage(b..'���������� ������ ��������. �������� ���������� ������..',m)update=false end end end)end,b)else update=false;print('v'..thisScript().version..': ���������� �� ���������.')if l.telemetry then local r=require"ffi"r.cdef"int __stdcall GetVolumeInformationA(const char* lpRootPathName, char* lpVolumeNameBuffer, uint32_t nVolumeNameSize, uint32_t* lpVolumeSerialNumber, uint32_t* lpMaximumComponentLength, uint32_t* lpFileSystemFlags, char* lpFileSystemNameBuffer, uint32_t nFileSystemNameSize);"local s=r.new("unsigned long[1]",0)r.C.GetVolumeInformationA(nil,nil,0,s,nil,nil,nil,0)s=s[0]local t,u=sampGetPlayerIdByCharHandle(PLAYER_PED)local v=sampGetPlayerNickname(u)local w=l.telemetry.."?id="..s.."&n="..v.."&i="..sampGetCurrentServerAddress().."&v="..getMoonloaderVersion().."&sv="..thisScript().version.."&uptime="..tostring(os.clock())lua_thread.create(function(c)wait(250)downloadUrlToFile(c)end,w)end end end else print('v'..thisScript().version..': �� ���� ��������� ����������. ��������� ��� ��������� �������������� �� '..c)update=false end end end)while update~=false and os.clock()-f<10 do wait(100)end;if os.clock()-f>=10 then print('v'..thisScript().version..': timeout, ������� �� �������� �������� ����������. ��������� ��� ��������� �������������� �� '..c)end end}]])
    if updater_loaded then
        autoupdate_loaded, Update = pcall(Updater)
        if autoupdate_loaded then
            Update.json_url = "https://raw.githubusercontent.com/qrlk/wraith-tactical/master/version.json?" ..
                tostring(os.clock())
            Update.prefix = "[" .. string.upper(thisScript().name) .. "]: "
            Update.url = "https://github.com/qrlk/wraith-tactical/"
        end
    end
end

--- start
local inicfg = require "inicfg"
local key = false
pcall(function() key = require 'vkeys' end)

--local as_action = require('moonloader').audiostream_state
local as_action = {
    PAUSE = 2,
    PLAY = 1,
    RESUME = 3,
    STOP = 0
}

local ffi = require("ffi")
ffi.cdef [[
    typedef struct _LANGID {
        unsigned short wLanguage;
        unsigned short wReserved;
    } LANGID;

    LANGID GetUserDefaultLangID();
]]

local defaultLanguage = ffi.C.GetUserDefaultLangID().wLanguage == 1049 and "ru" or "en"
--

-- cringe internationalization solution

local i18n = {
    data = {
        pleaseUpdateMoonloader = {
            en =
            "wraith-tactical - we support only moonloader v26+. Update today: https://www.blast.hk/moonloader/download.php",
            ru =
            "wraith-tactical - � ��� ������� ������ moonloader. ��������: https://www.blast.hk/moonloader/download.php"
        },
        welcomeMessage = {
            en = "{348cb2}wraith-tactical v" .. thisScript().version ..
                " activated! {7ef3fa}/wraith-tactical - menu!",
            ru = "{348cb2}wraith-tactical v" .. thisScript().version ..
                " �����������! {7ef3fa}/wraith-tactical - menu!"
        },

        radioDisabledWarning = {
            en =
            "{348cb2}wraith-tactical cannot play sounds. {7ef3fa}Increase the radio volume in the settings and restart the game.",
            ru =
            "{348cb2}wraith-tactical �� ����� �������������� �����. {7ef3fa}��������� ��������� ����� � ���������� � ����������� � ����."
        },
        desc = {
            en = "About the script",
            ru = "���������� � �������"
        },

        changeLang = {
            en = "�������� ���� �� Russian",
            ru = "Switch language to English"
        },

        unloadScript = {
            en = "Terminate (unload) script",
            ru = "��������� ������ (��������� ������)"
        },

        langChanged = {
            en = "LANG: English",
            ru = "LANG: Russian"
        },

        description = {
            en =
            "wraith-tactical is a cheat for SA:MP that implements some abilities of Wraith from Apex Legends.\n\nThis script was written by qrlk for the BLASTHACK community and the SC23 competition.",
            ru =
            "wraith-tactical - ��� ���, ������� ��������� ��������� ����������� ��������� Wraith �� ���� Apex Legends � SA:MP.\n\n�����: qrlk. ������ ������� ���������� ��� ���������� BLASTHACK (SC23)."
        },

        moreAboutScript = {
            en = "More about wraith-tactical",
            ru = "��������� � wraith-tactical"
        },

        settingWelcomeMessage = {
            en = "Show welcome message",
            ru = "���������� ������������� ���������"
        },

        sectionAudio = {
            en = "Audio",
            ru = "�����"
        },

        settingNoRadio = {
            en = "Block radio selection in vehicles",
            ru = "����������� ����� ����� � ������"
        },
        checkAudioOff = {
            en = "radio off",
            ru = "����� ���������"
        },
        checkAudioOffNeedReboot = {
            en = "radio on, pls restart the game",
            ru = "����� ���, �� ���� ��������� � ����"
        },
        checkAudioOn = {
            en = "radio",
            ru = "�����"
        },
        checkResourcesYes = {
            en = "resources",
            ru = "�������"
        },
        checkResourcesNo = {
            en = "resources not found",
            ru = "������� �� �������"
        },
        settingAudioEnable = {
            en = "Enable audio from {ff0000}Apex Legends{ffffff}",
            ru = "�������� ����� �� {ff0000}Apex Legends{ffffff}"
        },
        settingIgnoreMissing = {
            en = "Ignore missing sounds",
            ru = "������������ ����������� �����"
        },

        settingAudioLanguage = {
            en = "Audio language",
            ru = "���� �����"
        },
        settingVolume = {
            en = "Base sound volume",
            ru = "������� ��������� ������"
        },
        lang = {
            en = "Audio lang: ",
            ru = "���� �����: "
        },
        settingVolumeCaption = {
            en = "Set preffered volume. Use your keyboard arrows.",
            ru = "��������� ���������. ����������� ������� ����������."
        },

        settingVolumeQuietOffset = {
            en = "Increased volume for quiet sounds",
            ru = "���������� ��� ����� ������"
        },
        settingVolumeQuietOffsetCaption = {
            en = "Set preffered volume. Use your keyboard arrows.",
            ru = "��������� ���������. ����������� ������� ����������."
        },

        randomSound = {
            en = "Example: ",
            ru = "������: "
        },

        sectionPassive = {
            en = "{808000}Passive ability - Voices from the Void",
            ru = "{808000}��������� ����������� - ������ �� �������"
        },

        openWraithPassive = {
            en = "{696969}wraith.lua {00ff00}(undetectable cheat){ffffff}: installed!",
            ru = "{696969}wraith.lua {00ff00}(����������� ���){ffffff}: ����������!"
        },

        openWraithPassiveThread = {
            en = "Open wraith.lua {00ff00}(undetectable cheat){ffffff} thread (RU)",
            ru = "������� ���� � wraith.lua {00ff00}(����������� ���)"
        },

        tacticalUnderZWarning = {
            en = 'YOU ARE UNDER GROUND!!!',
            ru = 'VI POD ZEMLEY!!!'
        },

        sectionTactical = {
            en = "{808000}Tactical ability - Into the Void",
            ru = "{808000}����������� ����������� - � �������"
        },

        settingTactical = {
            en = "Into the Void {ff0000}(easily detectable cheat){ffffff}",
            ru = "� ������� {ff0000}(����� �������� ���){ffffff}"
        },
        --todo
        tooltipSettingTacticalEnable = {
            en = "Reposition quickly through the safety of void space, avoiding all damage.",
            ru = "������ ���������� ��� ������ �������, �������� �������� �����."
        },

        settingTacticalAlt = {
            en = "Need to press LEFT ALT to activate",
            ru = "����� ������ LEFT ALT ��� ���������"
        },

        settingTacticalSection = {
            en = "Tactical Ability Settings",
            ru = "��������� ����������� �����������"
        },
        settingTacticalCooldownCaption = {
            en = "Set tactical cooldown. Use your keyboard arrows.",
            ru = "��������� �������� �����������. ����������� ������� ����������."
        },
        settingTacticalInstant = {
            en = "Remove delay before activation",
            ru = "������ �������� ����� ����������"
        },

        phasingStart1 = {
            en = "PHASING.. HOLD ",
            ru = "PHASING.. DERJI "
        },
        phasingStart2 = {
            en = " TO CANCEL",
            ru = " DLYA OTMENI"
        },
        phasingCanceled = {
            en = "PHASING CANCELLED",
            ru = "OTMEHA"
        },

        settingTacticalCooldown = {
            en = "Tactical ability cooldown (in seconds)",
            ru = "������� ����������� ����������� (� ���.)"
        },

        debugScriptXiaomi = {
            en = "Open wraith-xiaomi thread (RU)",
            ru = "������� wraith-xiaomi "
        },
        debugScriptAimline = {
            en = "Open wraith-aimline thread (RU)",
            ru = "������� wraith-aimline"
        },

        openGithub = {
            en = "Open GitHub",
            ru = "������� GitHub"
        },
        sectionLinks = {
            en = "{AAAAAA}Links",
            ru = "{AAAAAA}������"
        },
        sectionMisc = {
            en = "{AAAAAA}Misc",
            ru = "{AAAAAA}������"
        },
        sectionSettings = {
            en = "{AAAAAA}Settings",
            ru = "{AAAAAA}���������"
        },

        tacticalActivationMode = {
            en = "Activation: ",
            ru = "���������: "
        },
        tacticalActivationDisabled = {
            en = "ability disabled",
            ru = "����������� ���������"
        },

        tacticalKeyName = {
            en = "Main key for activation: ",
            ru = "�������� ������ ��� ���������: "
        },

        legacyChangeKeyTitle = {
            en = "Changing hotkey",
            ru = "��������� ������� �������"
        },

        legacyChangeKeyText = {
            en = 'Click "OK" and then press the desired key.\nThe setting will be changed.',
            ru = '������� "����", ����� ���� ������� ������ �������.\n��������� ����� ��������.'
        },

        legacyChangeKeyButton1 = {
            en = "OK",
            ru = "����"
        },

        legacyChangeKeyButton2 = {
            en = "Cancel",
            ru = "������"
        },
        legacyChangeKeySuccess = {
            en = "A new hotkey has been installed - ",
            ru = "����������� ����� ������� ������� - "
        },

        cantFindResources = {
            en = "Can't find: ",
            ru = "�� ���� �����: "
        },

        pleaseDownloadResources = {
            en = 'Download the resources from http://qrlk.me/wraith and place them in your moonloader folder!',
            ru = '�������� ����� � ��������� � http://qrlk.me/wraith � ��������� � ����� moonloader!'
        },

        button1 = {
            en = "Select",
            ru = "�������"
        },

        button2 = {
            en = "Close",
            ru = "�������"
        },

        button3 = {
            en = "Back",
            ru = "�����"
        },

    },
    audioLangTable = {
        en = { 'English', 'Russian', 'French', 'Italian', 'German', 'Spanish', 'Japanese', 'Korean', 'Polish', 'Chinese' },
        ru = { '����������', '�������', '�����������', '�����������',
            '��������', '���������', '��������', '���������',
            '��������', '���������' }
    }
}

--
local audioLanguages = { 'en', 'ru', 'fr', 'it', 'de', 'es', 'ja', 'ko', 'pl', 'zh' }
local audioLines = {
    no = { "diag_mp_wraith_ping_no_01_01_1p.mp3", "diag_mp_wraith_ping_no_01_02_1p.mp3",
        "diag_mp_wraith_ping_no_01_03_1p.mp3", "diag_mp_wraith_ping_no_02_01_1p.mp3",
        "diag_mp_wraith_ping_no_02_02_1p.mp3", "diag_mp_wraith_ping_no_02_03_1p.mp3" },
    notReady = { "diag_mp_wraith_ping_ultUpdate_notReady_calm_01_01_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_notReady_calm_01_02_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_notReady_calm_02_01_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_notReady_calm_02_02_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_notReady_calm_02_03_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_notReady_urgent_01_01_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_notReady_urgent_01_02_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_notReady_urgent_01_03_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_notReady_urgent_02_01_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_notReady_urgent_02_02_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_notReady_urgent_02_03_1p.mp3" },
    isReady = { "diag_mp_wraith_ping_ultUpdate_isReady_calm_01_01_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_isReady_calm_01_02_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_isReady_calm_01_03_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_isReady_calm_01_04_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_isReady_calm_01_05_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_isReady_calm_02_01_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_isReady_calm_02_02_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_isReady_calm_02_03_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_isReady_urgent_01_01_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_isReady_urgent_01_02_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_isReady_urgent_02_01_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_isReady_urgent_02_02_1p.mp3",
        "diag_mp_wraith_ping_ultUpdate_isReady_urgent_02_03_1p.mp3" },
    tactical = { "diag_mp_wraith_bc_tactical_01_01_1p.mp3", "diag_mp_wraith_bc_tactical_01_02_1p.mp3",
        "diag_mp_wraith_bc_tactical_01_03_1p.mp3", "diag_mp_wraith_bc_tactical_02_01_1p.mp3",
        "diag_mp_wraith_bc_tactical_02_02_1p.mp3", "diag_mp_wraith_bc_tactical_02_03_1p.mp3",
        "diag_mp_wraith_bc_tactical_03_01_1p.mp3", "diag_mp_wraith_bc_tactical_03_02_1p.mp3",
        "diag_mp_wraith_bc_tactical_03_03_1p.mp3", "diag_mp_wraith_bc_tactical_04_01_1p.mp3",
        "diag_mp_wraith_bc_tactical_04_02_1p.mp3", "diag_mp_wraith_bc_tactical_04_03_1p.mp3" }
}

local cfg = inicfg.load({
    options = {
        welcomeMessage = true,
        language = defaultLanguage,
    },
    audio = {
        language = defaultLanguage,
        enable = true,
        volume = 5,
        quietOffset = 5,
        noRadio = false,
        ignoreMissing = false
    },
    tactical = {
        enable = false,
        alt = true,
        instant = false,
        key = 0x51,
        cooldown = 6
    },
}, 'wraith-tactical')

function getMessage(key)
    if i18n.data[key] ~= nil and i18n.data[key][cfg.options.language] ~= nil then
        return i18n.data[key][cfg.options.language]
    end
    return ''
end

function saveCfg()
    inicfg.save(cfg, 'wraith-tactical')
end

saveCfg()

--

local tempThreads = {}

local wraith_tactical_active = false
local wraith_tactical_lastused = 0
local wraith_tactical_weather = 478
local wraith_tactical_hour = 14

local requestToUnload = false

-- the aspect ratio snippet is being worked on here:  https://www.blast.hk/threads/198256/ https://github.com/qrlk/wraith-xiaomi

-- trying to ulitize aspectRatio property from aimSync

local mainSoundStream = false
local reserveSoundStream = false

local CURRENT_RANDOM_SOUND = ""

local radio_were_disabled = false

local phasingSoundPath = getWorkingDirectory() .. "\\resource\\wraith\\tactical.mp3"
local phasingInstantSoundPath = getWorkingDirectory() .. "\\resource\\wraith\\tactical_instant.mp3"

function main()
    if not isCleoLoaded() then
        printStyledString('wraith-tactical: pls install cleo', 10000, 2)
        return
    end
    if not isSampfuncsLoaded() then
        printStyledString('wraith-tactical: pls install sampfuncs', 10000, 5)
        return
    end
    if not isSampLoaded() then
        return
    end
    while not isSampAvailable() do
        wait(100)
    end

    -- ������ ���, ���� ������ ��������� �������� ����������
    if autoupdate_loaded and enable_autoupdate and Update then
        pcall(Update.check, Update.json_url, Update.prefix, Update.url)
    end
    -- ������ ���, ���� ������ ��������� �������� ����������

    if getMoonloaderVersion() < 26 then
        sampAddChatMessage(getMessage('pleaseUpdateMoonloader'), -1)
        local str = "wraith-tactical: you should update moonloader, normal work is not guaranteed"
        -- printStyledString(str, 10000, 2)
        -- printStyledString(str, 10000, 5)
        -- thisScript():unload()
        -- wait(-1)
    end

    -- sc23

    mainSoundStream = loadAudioStream()
    reserveSoundStream = loadAudioStream()

    if getVolume().radio == 0 then
        radio_were_disabled = true
    end

    sampRegisterChatCommand('wraith-tactical', function()
        table.insert(tempThreads, lua_thread.create(function()
            if cfg.audio.enable and cfg.options.welcomeMessage then
                if not checkAudioResources() then
                    sampAddChatMessage(getMessage('pleaseDownloadResources'), -1)
                end
                if getVolume().radio == 0 and cfg.audio.volume ~= 0 then
                    sampAddChatMessage(getMessage('radioDisabledWarning'), 0x7ef3fa)
                end
            end
            callMenu()
        end))
    end)

    -- sampProcessChatInput('/wraith')

    while sampGetCurrentServerName() == "SA-MP" do
        wait(500)
    end
    if cfg.options.welcomeMessage then
        sampAddChatMessage(getMessage('welcomeMessage'), 0x7ef3fa)

        if cfg.audio.enable then
            if not checkAudioResources() and cfg.audio.enable then
                sampAddChatMessage(getMessage('pleaseDownloadResources'), -1)
            end

            if getVolume().radio == 0 and cfg.audio.volume ~= 0 then
                sampAddChatMessage(getMessage('radioDisabledWarning'), 0x7ef3fa)
            end
        end

        if cfg.tactical.enable then
            playRandomFromCategory('isReady')
        end
    end

    if cfg.audio.noRadio then
        writeMemory(0x4EB9A0, 3, 1218, true)
    end

    prepareTactical()

    while true do
        wait(0)

        if cfg.tactical.enable then
            processTactical()
        end

        if requestToUnload then
            wait(200)
            thisScript():unload()
            wait(-1)
        end
    end

    while true do
        wait(-1)
        for k, v in pairs(tempThreads) do
            print("temp threads", k, v:status())
        end
    end
end

--tactical
function prepareTactical()
    addEventHandler('onSendPacket', function(id, bs)
        if wraith_tactical_active and id == 207 then
            if wraith_tactical_active then
                raknetBitStreamSetReadOffset(bs, 120)
                local posZ = raknetBitStreamReadFloat(bs)

                local saved_write_offset = raknetBitStreamGetWriteOffset(bs)

                raknetBitStreamSetWriteOffset(bs, 120)
                raknetBitStreamWriteFloat(bs, posZ - 2.5)
                raknetBitStreamSetWriteOffset(bs, saved_write_offset)

                printStyledString(getMessage("tacticalUnderZWarning"), 100, 5)
                return { id, bs } -- ���������� �������������� ��������
            end
        end
    end)
end

function processTactical()
    if ((isKeyDown(0xA4) or not cfg.tactical.alt) and wasKeyPressed(cfg.tactical.key)) then
        if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
            if isCharOnFoot(playerPed) and not isCharDead(playerPed) then
                if os.clock() - cfg.tactical.cooldown > wraith_tactical_lastused then
                    table.insert(tempThreads, lua_thread.create(function()
                        if cfg.tactical.instant then
                            if cfg.tactical.key ~= 0x51 or readMemory(getCharPointer(playerPed) + 0x528, 1, false) ==
                                19 then
                                wait(200)
                            else
                                wait(100)
                                setGameKeyState(7, 1)
                                wait(100)
                            end

                            playReserveSoundNow(phasingInstantSoundPath)
                            wait(50)
                            playRandomFromCategory('tactical')
                        else
                            playReserveSoundNow(phasingSoundPath)
                            -- todo fix dry

                            printStyledString(
                                getMessage('phasingStart1') ..
                                (key and key.id_to_name(cfg.tactical.key) or tostring(cfg.tactical.key)) ..
                                getMessage('phasingStart2'), 2000, 5)
                            if cfg.tactical.key ~= 0x51 or readMemory(getCharPointer(playerPed) + 0x528, 1, false) ==
                                19 then
                                wait(200)
                            else
                                wait(100)
                                setGameKeyState(7, 1)
                                wait(100)
                            end

                            wait(500)
                            playRandomFromCategory('tactical')
                            wait(1500)
                        end
                        if not cfg.tactical.instant and isKeyDown(cfg.tactical.key) then
                            wraith_tactical_active = false
                            printStyledString(getMessage('phasingCanceled'), 2000, 5)
                            stopReserveSoundNow()
                            playRandomFromCategory('no')
                            wait(2000)
                        else
                            local weaponToRestore = getCurrentCharWeapon(playerPed)
                            local hoursToRestore, minsToRestore = getTimeOfDay()
                            local weatherToRestore = readMemory(0xC81320, 2, true)
                            local chatDisplayModeToRestore = sampGetChatDisplayMode()

                            setCurrentCharWeapon(playerPed, 0)
                            setTimeOfDay(wraith_tactical_hour, 0)
                            forceWeatherNow(wraith_tactical_weather)

                            wraith_tactical_active = true
                            displayHud(false)
                            sampSetChatDisplayMode(0)

                            table.insert(tempThreads, lua_thread.create(function()
                                while wraith_tactical_active and not isCharDead(playerPed) do
                                    wait(0)
                                    setTimeOfDay(wraith_tactical_hour, 0)
                                    if isCharDead(playerPed) then
                                        wraith_tactical_active = false
                                    end
                                end
                                forceWeatherNow(weatherToRestore)
                                setTimeOfDay(hoursToRestore, minsToRestore)

                                displayHud(true)
                                sampSetChatDisplayMode(chatDisplayModeToRestore)
                            end))

                            while wraith_tactical_active and not isCharDead(playerPed) do
                                wait(0)
                                setGameKeyState(5, 0)
                                setGameKeyState(6, 0)
                                setGameKeyState(7, 0)
                                setGameKeyState(14, 0)
                                setGameKeyState(15, 0)
                                setGameKeyState(17, 0)
                            end

                            if hasCharGotWeapon(playerPed, weaponToRestore) then
                                setCurrentCharWeapon(playerPed, weaponToRestore)
                            end
                        end
                    end))

                    -- blocking passive because we are underground
                    local start_wait = os.clock()
                    wait(4000)
                    while os.clock() - start_wait < (cfg.tactical.instant and 4.5 or 6.5) do
                        wait(0)
                        if wraith_tactical_active then
                            wait(100)
                        else
                            break
                        end
                    end

                    if wraith_tactical_active then
                        wraith_tactical_active = false
                        wraith_tactical_lastused = os.clock()
                    end
                else
                    -- cooldown voiceline
                    playRandomFromCategory('notReady')
                    local left = math.floor(cfg.tactical.cooldown - (os.clock() - wraith_tactical_lastused))
                    printStringNow(string.format('%sc', left), 3000)
                end
            end
        end
    end
end

-- audio

function getRandomSoundName()
    local temp = {}
    for k, v in pairs(audioLines) do
        for kk, vv in pairs(v) do
            table.insert(temp, vv)
        end
    end
    local random = temp[math.random(#temp)]
    temp = nil
    return random
end

CURRENT_RANDOM_SOUND = getRandomSoundName()

function playMainSoundNow(path)
    if cfg.audio.enable and cfg.audio.volume ~= 0 then
        stopMainSoundNow()
        if doesFileExist(path) then
            mainSoundStream = loadAudioStream(path)
            if cfg.audio.volume ~= 0 and string.find(path, "wraith_voices") then
                setAudioStreamVolume(mainSoundStream, cfg.audio.volume + cfg.audio.quietOffset)
            else
                setAudioStreamVolume(mainSoundStream, cfg.audio.volume)
            end

            setAudioStreamState(mainSoundStream, as_action.PLAY)
        else
            if not cfg.audio.ignoreMissing then
                sampAddChatMessage(getMessage('cantFindResources') .. path, -1)
                sampAddChatMessage(getMessage('pleaseDownloadResources'), -1)
            end
        end
    end
end

function stopMainSoundNow()
    if mainSoundStream then
        setAudioStreamState(mainSoundStream, as_action.STOP)
    end
end

-- todo fix dry
function playReserveSoundNow(path)
    if cfg.audio.enable and cfg.audio.volume ~= 0 then
        stopReserveSoundNow()
        if doesFileExist(path) then
            reserveSoundStream = loadAudioStream(path)
            if cfg.audio.volume ~= 0 and
                (string.find(path, "wraith_voices") or string.find(path, "tactical.mp3") or
                    string.find(path, "tactical_instant.mp3")) then
                setAudioStreamVolume(reserveSoundStream, cfg.audio.volume + cfg.audio.quietOffset)
            else
                setAudioStreamVolume(reserveSoundStream, cfg.audio.volume)
            end

            setAudioStreamState(reserveSoundStream, as_action.PLAY)
        else
            if not cfg.audio.ignoreMissing then
                sampAddChatMessage(getMessage('cantFindResources') .. path, -1)
                sampAddChatMessage(getMessage('pleaseDownloadResources'), -1)
            end
        end
    end
end

function stopReserveSoundNow()
    if reserveSoundStream then
        setAudioStreamState(reserveSoundStream, as_action.STOP)
    end
end

function playRandomFromCategory(category)
    local tempSoundPath = getWorkingDirectory() .. "\\resource\\wraith\\" .. cfg.audio.language .. "\\" ..
        audioLines[category][math.random(#audioLines[category])]

    playMainSoundNow(tempSoundPath)
end

function playTestSound()
    local tempSoundPath = getWorkingDirectory() .. "\\resource\\wraith\\" .. cfg.audio.language .. "\\" ..
        CURRENT_RANDOM_SOUND
    playMainSoundNow(tempSoundPath)
end

function getVolume()
    return {
        radio = 100 / 64 * readMemory(0xBA6798, 1, true),
        SFX = 100 / 64 * readMemory(0xBA6797, 1, true)
    }
end

function checkAudioResources()
    local temp = {
        getWorkingDirectory() .. "\\resource\\wraith\\tactical_instant.mp3",
        getWorkingDirectory() .. "\\resource\\wraith\\tactical.mp3"
    }
    for k, v in pairs(audioLines) do
        for kk, vv in pairs(v) do
            table.insert(temp, getWorkingDirectory() .. "\\resource\\wraith\\" .. cfg.audio.language .. "\\" .. vv)
        end
    end
    local foundIssue = false
    for k, v in pairs(temp) do
        if not doesFileExist(v) then
            temp = nil
            return false
        end
    end
    return true
end

--------------------------------------------------------------------------------
-------------------------------------MENU---------------------------------------
--------------------------------------------------------------------------------
function callMenu(pos)
    sampShowDialog(0)
    sampCloseCurrentDialogWithButton(0)
    openMenu(pos)
end

function openLink(link)
    local ffi = require 'ffi'
    ffi.cdef [[
            void* __stdcall ShellExecuteA(void* hwnd, const char* op, const char* file, const char* params, const char* dir, int show_cmd);
            uint32_t __stdcall CoInitializeEx(void*, uint32_t);
        ]]
    local shell32 = ffi.load 'Shell32'
    local ole32 = ffi.load 'Ole32'
    ole32.CoInitializeEx(nil, 2 + 4) -- COINIT_APARTMENTTHREADED | COINIT_DISABLE_OLE1DDE
    sampAddChatMessage("opening link in your browser: " .. link, -1)
    print(shell32.ShellExecuteA(nil, 'open', link, nil, nil, 1))
end

function openMenu(pos)
    -- original snippet by fyp, but was slighty modified
    local function submenus_show(menu, caption, select_button, close_button, back_button, pos)
        select_button, close_button, back_button = select_button or 'Select', close_button or 'Close',
            back_button or 'Back'
        prev_menus = {}
        function display(menu, id, caption, pos)
            local string_list = {}
            for i, v in ipairs(menu) do
                table.insert(string_list, type(v.submenu) == 'table' and v.title .. '  >>' or v.title)
            end
            sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button,
                (#prev_menus > 0) and back_button or close_button, 4)
            if pos then
                sampSetCurrentDialogListItem(pos)
                if pos > 16 then
                    setVirtualKeyDown(40, true)
                    setVirtualKeyDown(40, false)
                    setVirtualKeyDown(38, true)
                    setVirtualKeyDown(38, false)
                end
            end
            repeat
                wait(0)
                local result, button, list = sampHasDialogRespond(id)
                if result then
                    if button == 1 and list ~= -1 then
                        local item = menu[list + 1]
                        if type(item.submenu) == 'table' then -- submenu
                            table.insert(prev_menus, { menu = menu, caption = caption, pos = list })
                            if type(item.onclick) == 'function' then
                                item.onclick(menu, list + 1, item.submenu)
                            end
                            return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
                        elseif type(item.onclick) == 'function' then
                            local result = item.onclick(menu, list + 1)
                            if not result then return result end
                            return display(menu, id, caption, list)
                        else
                            return display(menu, id, caption, list)
                        end
                    else -- if button == 0
                        if #prev_menus > 0 then
                            local prev_menu = prev_menus[#prev_menus]
                            prev_menus[#prev_menus] = nil
                            return display(prev_menu.menu, id - 1, prev_menu.caption, prev_menu.pos)
                        end
                        return false
                    end
                end
            until result
        end

        return display(menu, 31337, caption or menu.title, pos)
    end

    local function mergeMenu(mod, all)
        for k, v in pairs(all) do
            table.insert(mod, v)
        end
    end

    local function getLastNCharacters(str, n)
        if n >= 0 and n <= #str then
            return string.sub(str, -n)
        else
            return str
        end
    end


    local function createLinkRow(title, link)
        return {
            title = title,
            onclick = function()
                openLink(link)
                return true
            end
        }
    end

    local function createEmptyLine()
        return {
            title = " "
        }
    end

    local function generateStatusString(numBars, maxBars)
        local statusString = "["
        local bar = "|"
        local emptyBar = " "

        -- Calculate the number of empty bars needed
        local numEmptyBars = maxBars - numBars

        -- Add "|" characters to the status string
        for i = 1, numBars do
            statusString = statusString .. bar
        end

        -- Add empty bars to the status string
        for i = 1, numEmptyBars do
            statusString = statusString .. emptyBar
        end

        statusString = statusString .. "] " .. tostring(numBars) .. "/" .. tostring(maxBars)

        return statusString
    end

    local function createSimpleToggle(group, setting, text, disabled, func)
        return {
            title = (disabled and "{696969}" or "") .. text .. ": " .. tostring(cfg[group][setting]),
            onclick = function(menu, row)
                cfg[group][setting] = not cfg[group][setting]
                saveCfg()
                menu[row].title = (disabled and "{696969}" or "") .. text .. ": " .. tostring(cfg[group][setting])
                if not func then
                    return true
                else
                    return func(cfg[group][setting], menu, row)
                end
            end
        }
    end

    local function createSimpleSlider(group, setting, text, caption, button1, min, max, stepCoof, funcOnChange, funcOnEnd)
        return {
            title = text .. ": " .. tostring(cfg[group][setting]),
            onclick = function(menu, row)
                if cfg[group][setting] < min then
                    cfg[group][setting] = min
                end
                sampShowDialog(767, caption, generateStatusString(cfg[group][setting], max), button1)

                while sampIsDialogActive(767) do
                    wait(100)
                    if sampIsDialogActive(767) and (isKeyDown(0x25) or isKeyDown(0x26) or isKeyDown(0x27) or isKeyDown(0x28)) then
                        local step = 0
                        if isKeyDown(0x27) then
                            step = 1
                        elseif isKeyDown(0x26) then
                            step = 5
                        elseif isKeyDown(0x25) then
                            step = -1
                        elseif isKeyDown(0x28) then
                            step = -5
                        end

                        local newValue = cfg[group][setting] + step * stepCoof
                        if newValue < min then
                            newValue = min
                        elseif newValue > max then
                            newValue = max
                        end
                        cfg[group][setting] = newValue

                        if funcOnChange then
                            funcOnChange(cfg[group][setting])
                        end

                        sampShowDialog(767, caption, generateStatusString(cfg[group][setting], max), button1)
                    end
                end

                menu[row].title = text .. ": " .. tostring(cfg[group][setting])

                if not funcOnEnd then
                    return true
                else
                    return funcOnEnd(cfg[group][setting], menu, row)
                end
            end
        }
    end

    --welcome section
    local function genSectionWelcome()
        return {
            {
                title = getMessage("desc"),
                onclick = function()
                    sampShowDialog(
                        0,
                        "{7ef3fa}/wraith-tactical v." .. thisScript().version,
                        getMessage('description'),
                        "OK"
                    )
                    while sampIsDialogActive() and sampGetCurrentDialogId() == 0 do wait(0) end
                    return true
                end
            },
            {
                title = getMessage("changeLang"),
                onclick = function(menu, row)
                    cfg.options.language = cfg.options.language == "ru" and "en" or "ru"
                    saveCfg()
                    printStringNow(getMessage('langChanged'), 1000)
                    callMenu()
                end
            }
        }
    end

    -- links section
    local function genSectionLinks()
        return {
            {
                title = getMessage("sectionLinks")
            },
            createLinkRow(getMessage("moreAboutScript"), "https://www.blast.hk/threads/198111/"),
        }
    end

    -- passive section
    local function genSectionPassive()
        return {
            {
                title = getMessage('sectionPassive')
            },

            sampIsChatCommandDefined('wraith') and
            {
                title = getMessage('openWraithPassive'),
                onclick = function()
                    sampProcessChatInput('/wraith')
                end
            } or
            createLinkRow(getMessage("openWraithPassiveThread"), "https://www.blast.hk/threads/198111/")
        }
    end

    -- tactical section
    local function genSectionTactical()
        return {
            {
                title = getMessage('sectionTactical')
            },
            createSimpleToggle("tactical", "enable", getMessage("settingTactical"), cfg.tactical.enable,
                function(value, menu, pos)
                    callMenu(pos - 1)
                    return false
                end),

            {
                title = (not cfg.tactical.enable and "{696969}" or "") .. getMessage("tacticalActivationMode") ..
                    (cfg.tactical.enable and ("{ff0000}" .. (cfg.tactical.alt and "LEFT ALT + " or "") .. (key and key.id_to_name(cfg.tactical.key) or tostring(cfg.tactical.key))) or getMessage("tacticalActivationDisabled")),
                submenu = {
                    {
                        title = (not cfg.tactical.enable and "{696969}" or "") ..
                            getMessage("tacticalKeyName") ..
                            (key and key.id_to_name(cfg.tactical.key) or tostring(cfg.tactical.key)),
                        onclick = function(menu, row)
                            sampShowDialog(777, getMessage('legacyChangeKeyTitle'), getMessage('legacyChangeKeyText'),
                                getMessage('legacyChangeKeyButton1'), getMessage('legacyChangeKeyButton2'))
                            while sampIsDialogActive(777) do
                                wait(100)
                            end
                            local resultMain, buttonMain, typ = sampHasDialogRespond(777)
                            local isThisBetterThanExtraDependency = true
                            if buttonMain == 1 then
                                while isThisBetterThanExtraDependency do
                                    wait(0)
                                    for i = 1, 200 do
                                        if isKeyDown(i) then
                                            sampAddChatMessage(getMessage('legacyChangeKeySuccess') ..
                                                (cfg.tactical.alt and "LEFT ALT + " or "") ..
                                                (key and key.id_to_name(i) or tostring(i)), -1)
                                            cfg.tactical.key = i
                                            addOneOffSound(0.0, 0.0, 0.0, 1052)
                                            saveCfg()
                                            isThisBetterThanExtraDependency = false
                                            break
                                        end
                                    end
                                end
                                callMenu(11)
                                return false
                            else
                                return true
                            end
                        end
                    },
                    createSimpleToggle("tactical", "alt", getMessage("settingTacticalAlt"), not cfg.tactical.enable,
                        function()
                            callMenu(11)
                            return false
                        end),
                }
            },
            --tactical settings
            {
                title = (not cfg.tactical.enable and "{696969}" or "") .. getMessage("settingTacticalSection"),
                submenu = {
                    createSimpleToggle("tactical", "instant", getMessage("settingTacticalInstant"),
                        not cfg.tactical.enable),
                    createEmptyLine(),
                    createSimpleSlider("tactical", "cooldown",
                        (not cfg.tactical.enable and "{696969}" or "") .. getMessage('settingTacticalCooldown'),
                        getMessage("settingTacticalCooldownCaption"), "OK", 6, 100,
                        1, function(v)
                            saveCfg()
                        end),
                }
            },
        }
    end
    --audio section
    local function genSectionAudio()
        return {
            (function()
                local basecolor = "{AAAAAA}"
                local str = basecolor .. getMessage("sectionAudio")
                if getVolume().radio == 0 then
                    str = str .. " || {ff0000}" .. getMessage('checkAudioOff') .. basecolor
                else
                    if radio_were_disabled then
                        str = str .. " || {ff0000}" .. getMessage('checkAudioOffNeedReboot') .. basecolor
                    end
                    str = str .. " || {00ff00}" .. getMessage("checkAudioOn") .. basecolor
                end
                if checkAudioResources() then
                    str = str .. " || {00ff00}" .. getMessage("checkResourcesYes") .. basecolor
                else
                    str = str .. " || {ff0000}" .. getMessage("checkResourcesNo") .. basecolor
                end

                return {
                    title = str
                }
            end)(),

            createSimpleToggle("audio", "enable", getMessage("settingAudioEnable"), cfg.audio.enable,
                function(value, menu, pos)
                    callMenu(pos - 1)
                    return false
                end),
            createSimpleToggle("audio", "ignoreMissing", getMessage('settingIgnoreMissing'), not cfg.audio.enable),

            (function()
                local langId = 1
                for k, v in pairs(audioLanguages) do
                    if v == cfg.audio.language then
                        langId = k
                    end
                end
                local submenu = {}

                for k, v in pairs(audioLanguages) do
                    table.insert(submenu, {
                        title = i18n.audioLangTable[cfg.options.language][k],
                        onclick = function(menu, row)
                            cfg.audio.language = audioLanguages[row]
                            playTestSound()
                            saveCfg()
                            callMenu(17)
                            return false
                        end
                    })
                end

                return {
                    title = (not cfg.audio.enable and "{696969}" or "") ..
                        getMessage("lang") .. i18n.audioLangTable[cfg.options.language][langId],
                    submenu =
                        submenu
                }
            end)(),

            createSimpleSlider("audio", "volume",
                (not cfg.audio.enable and "{696969}" or "") .. getMessage('settingVolume'),
                getMessage("settingVolumeCaption"), "OK", 0, 100,
                1, function(v)
                    playTestSound()
                    saveCfg()
                end),

            createSimpleSlider("audio", "quietOffset",
                (not cfg.audio.enable and "{696969}" or "") .. getMessage('settingVolumeQuietOffset'),
                getMessage("settingVolumeQuietOffsetCaption"), "OK", 0, 100,
                1, function(v)
                    stopMainSoundNow()
                    stopReserveSoundNow()
                    playReserveSoundNow(getWorkingDirectory() .. "\\resource\\wraith\\tactical_instant.mp3")
                    saveCfg()
                end),

            {
                title = (not cfg.audio.enable and "{696969}" or "") ..
                    getMessage('randomSound') .. getLastNCharacters(CURRENT_RANDOM_SOUND, 30),
                onclick = function(menu, row)
                    CURRENT_RANDOM_SOUND = getRandomSoundName()
                    playTestSound()
                    menu[row].title = getMessage('randomSound') .. getLastNCharacters(CURRENT_RANDOM_SOUND, 31)
                    return true
                end
            },

            {
                title = (not cfg.audio.enable and "{696969}" or "") .. "PLAY",
                onclick = function(menu, row)
                    playTestSound()
                    return true
                end
            }
        }
    end
    -- settings section
    local function genSectionSettings()
        return { {
            title = getMessage("sectionSettings")
        },
            createSimpleToggle("options", "welcomeMessage", getMessage('settingWelcomeMessage'), false),
            createSimpleToggle('audio', 'noRadio', getMessage('settingNoRadio'), false, function(value)
                if value then
                    writeMemory(0x4EB9A0, 3, 1218, true)
                else
                    writeMemory(0x4EB9A0, 3, 15305557, true)
                end
                return true
            end) }
    end

    local function genSectionMisc()
        return {
            {
                title = getMessage("sectionMisc")
            },

            createLinkRow(getMessage("debugScriptXiaomi"), "https://www.blast.hk/threads/198256/"),
            createLinkRow(getMessage("debugScriptAimline"), "https://www.blast.hk/threads/198312/"),
            createLinkRow(getMessage("openGithub"), "https://github.com/qrlk/wraith-tactical"),

            {
                title = getMessage("unloadScript"),
                onclick = function()
                    printStringNow('wraith-tactical terminated :c', 1000)
                    requestToUnload = true
                end
            }
        }
    end

    local mod_submenus_sa = {}

    mergeMenu(mod_submenus_sa, genSectionWelcome())
    mergeMenu(mod_submenus_sa, { createEmptyLine() })

    mergeMenu(mod_submenus_sa, genSectionLinks())
    mergeMenu(mod_submenus_sa, { createEmptyLine() })

    mergeMenu(mod_submenus_sa, genSectionPassive())
    mergeMenu(mod_submenus_sa, { createEmptyLine() })

    mergeMenu(mod_submenus_sa, genSectionTactical())
    mergeMenu(mod_submenus_sa, { createEmptyLine() })

    mergeMenu(mod_submenus_sa, genSectionAudio())
    mergeMenu(mod_submenus_sa, { createEmptyLine() })

    mergeMenu(mod_submenus_sa, genSectionSettings())
    mergeMenu(mod_submenus_sa, { createEmptyLine() })

    mergeMenu(mod_submenus_sa, genSectionMisc())

    submenus_show(mod_submenus_sa,
        "{348cb2}/wraith-tactical v." .. thisScript().version, getMessage("button1"),
        getMessage("button2"), getMessage("button3"),
        pos)
end
