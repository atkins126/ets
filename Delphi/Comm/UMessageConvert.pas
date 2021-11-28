{
  Copyright (c) 2021-2031 Steven Shi

  ETS(Extended Tool Set)，可扩展工具集。

  本工具软件是开源自由软件，您可以遵照 MIT 协议，修改和发布此程序。
  发布此库的目的是希望其有用，但不做任何保证。
  如果将本库用于商业项目，由于本库中的Bug，而引起的任何风险及损失，本作者不承担任何责任。

  开源地址: https://github.com/ets-ddui/ets
  开源协议: The MIT License (MIT)
  作者邮箱: xinghun87@163.com
  官方博客：https://blog.csdn.net/xinghun61
}
unit UMessageConvert;

interface

function GetMessageName(AMessage: Integer): String;

implementation

uses
  Messages, Controls, SysUtils;

var
  GMessageName: array[-2..48656] of String;

function GetMessageName(AMessage: Integer): String;
  procedure setMessageName(AName: String; AValue: Integer);
  begin
    if (AValue < Low(GMessageName)) or (AValue > High(GMessageName)) then
      Exit;

    if GMessageName[AValue] = '' then
      GMessageName[AValue] := AName
    else
      GMessageName[AValue] := GMessageName[AValue] + ',' + AName;
  end;

  procedure initMessageName;
  begin
    setMessageName('LBN_ERRSPACE', LBN_ERRSPACE);
    setMessageName('CBN_ERRSPACE', CBN_ERRSPACE);
    setMessageName('BN_CLICKED', BN_CLICKED);
    setMessageName('WM_NULL', WM_NULL);
    setMessageName('BN_PAINT', BN_PAINT);
    setMessageName('CBN_SELCHANGE', CBN_SELCHANGE);
    setMessageName('LBN_SELCHANGE', LBN_SELCHANGE);
    setMessageName('WM_CREATE', WM_CREATE);
    setMessageName('BN_HILITE', BN_HILITE);
    setMessageName('BN_PUSHED', BN_PUSHED);
    setMessageName('CBN_DBLCLK', CBN_DBLCLK);
    setMessageName('LBN_DBLCLK', LBN_DBLCLK);
    setMessageName('WM_DESTROY', WM_DESTROY);
    setMessageName('BN_UNHILITE', BN_UNHILITE);
    setMessageName('BN_UNPUSHED', BN_UNPUSHED);
    setMessageName('CBN_SETFOCUS', CBN_SETFOCUS);
    setMessageName('LBN_SELCANCEL', LBN_SELCANCEL);
    setMessageName('WM_MOVE', WM_MOVE);
    setMessageName('BN_DISABLE', BN_DISABLE);
    setMessageName('CBN_KILLFOCUS', CBN_KILLFOCUS);
    setMessageName('LBN_SETFOCUS', LBN_SETFOCUS);
    setMessageName('BN_DBLCLK', BN_DBLCLK);
    setMessageName('BN_DOUBLECLICKED', BN_DOUBLECLICKED);
    setMessageName('CBN_EDITCHANGE', CBN_EDITCHANGE);
    setMessageName('LBN_KILLFOCUS', LBN_KILLFOCUS);
    setMessageName('WM_SIZE', WM_SIZE);
    setMessageName('BN_SETFOCUS', BN_SETFOCUS);
    setMessageName('CBN_EDITUPDATE', CBN_EDITUPDATE);
    setMessageName('WM_ACTIVATE', WM_ACTIVATE);
    setMessageName('BN_KILLFOCUS', BN_KILLFOCUS);
    setMessageName('CBN_DROPDOWN', CBN_DROPDOWN);
    setMessageName('WM_SETFOCUS', WM_SETFOCUS);
    setMessageName('CBN_CLOSEUP', CBN_CLOSEUP);
    setMessageName('WM_KILLFOCUS', WM_KILLFOCUS);
    setMessageName('CBN_SELENDOK', CBN_SELENDOK);
    setMessageName('CBN_SELENDCANCEL', CBN_SELENDCANCEL);
    setMessageName('WM_ENABLE', WM_ENABLE);
    setMessageName('WM_SETREDRAW', WM_SETREDRAW);
    setMessageName('WM_SETTEXT', WM_SETTEXT);
    setMessageName('WM_GETTEXT', WM_GETTEXT);
    setMessageName('WM_GETTEXTLENGTH', WM_GETTEXTLENGTH);
    setMessageName('WM_PAINT', WM_PAINT);
    setMessageName('WM_CLOSE', WM_CLOSE);
    setMessageName('WM_QUERYENDSESSION', WM_QUERYENDSESSION);
    setMessageName('WM_QUIT', WM_QUIT);
    setMessageName('WM_QUERYOPEN', WM_QUERYOPEN);
    setMessageName('WM_ERASEBKGND', WM_ERASEBKGND);
    setMessageName('WM_SYSCOLORCHANGE', WM_SYSCOLORCHANGE);
    setMessageName('WM_ENDSESSION', WM_ENDSESSION);
    setMessageName('WM_SYSTEMERROR', WM_SYSTEMERROR);
    setMessageName('WM_SHOWWINDOW', WM_SHOWWINDOW);
    setMessageName('WM_CTLCOLOR', WM_CTLCOLOR);
    setMessageName('WM_SETTINGCHANGE', WM_SETTINGCHANGE);
    setMessageName('WM_WININICHANGE', WM_WININICHANGE);
    setMessageName('WM_DEVMODECHANGE', WM_DEVMODECHANGE);
    setMessageName('WM_ACTIVATEAPP', WM_ACTIVATEAPP);
    setMessageName('WM_FONTCHANGE', WM_FONTCHANGE);
    setMessageName('WM_TIMECHANGE', WM_TIMECHANGE);
    setMessageName('WM_CANCELMODE', WM_CANCELMODE);
    setMessageName('WM_SETCURSOR', WM_SETCURSOR);
    setMessageName('WM_MOUSEACTIVATE', WM_MOUSEACTIVATE);
    setMessageName('WM_CHILDACTIVATE', WM_CHILDACTIVATE);
    setMessageName('WM_QUEUESYNC', WM_QUEUESYNC);
    setMessageName('WM_GETMINMAXINFO', WM_GETMINMAXINFO);
    setMessageName('WM_PAINTICON', WM_PAINTICON);
    setMessageName('WM_ICONERASEBKGND', WM_ICONERASEBKGND);
    setMessageName('WM_NEXTDLGCTL', WM_NEXTDLGCTL);
    setMessageName('WM_SPOOLERSTATUS', WM_SPOOLERSTATUS);
    setMessageName('WM_DRAWITEM', WM_DRAWITEM);
    setMessageName('WM_MEASUREITEM', WM_MEASUREITEM);
    setMessageName('WM_DELETEITEM', WM_DELETEITEM);
    setMessageName('WM_VKEYTOITEM', WM_VKEYTOITEM);
    setMessageName('WM_CHARTOITEM', WM_CHARTOITEM);
    setMessageName('WM_SETFONT', WM_SETFONT);
    setMessageName('WM_GETFONT', WM_GETFONT);
    setMessageName('WM_SETHOTKEY', WM_SETHOTKEY);
    setMessageName('WM_GETHOTKEY', WM_GETHOTKEY);
    setMessageName('WM_QUERYDRAGICON', WM_QUERYDRAGICON);
    setMessageName('WM_COMPAREITEM', WM_COMPAREITEM);
    setMessageName('WM_GETOBJECT', WM_GETOBJECT);
    setMessageName('WM_COMPACTING', WM_COMPACTING);
    setMessageName('WM_COMMNOTIFY', WM_COMMNOTIFY);
    setMessageName('WM_WINDOWPOSCHANGING', WM_WINDOWPOSCHANGING);
    setMessageName('WM_WINDOWPOSCHANGED', WM_WINDOWPOSCHANGED);
    setMessageName('WM_POWER', WM_POWER);
    setMessageName('WM_COPYDATA', WM_COPYDATA);
    setMessageName('WM_CANCELJOURNAL', WM_CANCELJOURNAL);
    setMessageName('WM_NOTIFY', WM_NOTIFY);
    setMessageName('WM_INPUTLANGCHANGEREQUEST', WM_INPUTLANGCHANGEREQUEST);
    setMessageName('WM_INPUTLANGCHANGE', WM_INPUTLANGCHANGE);
    setMessageName('WM_TCARD', WM_TCARD);
    setMessageName('WM_HELP', WM_HELP);
    setMessageName('WM_USERCHANGED', WM_USERCHANGED);
    setMessageName('WM_NOTIFYFORMAT', WM_NOTIFYFORMAT);
    setMessageName('WM_CONTEXTMENU', WM_CONTEXTMENU);
    setMessageName('WM_STYLECHANGING', WM_STYLECHANGING);
    setMessageName('WM_STYLECHANGED', WM_STYLECHANGED);
    setMessageName('WM_DISPLAYCHANGE', WM_DISPLAYCHANGE);
    setMessageName('WM_GETICON', WM_GETICON);
    setMessageName('WM_SETICON', WM_SETICON);
    setMessageName('WM_NCCREATE', WM_NCCREATE);
    setMessageName('WM_NCDESTROY', WM_NCDESTROY);
    setMessageName('WM_NCCALCSIZE', WM_NCCALCSIZE);
    setMessageName('WM_NCHITTEST', WM_NCHITTEST);
    setMessageName('WM_NCPAINT', WM_NCPAINT);
    setMessageName('WM_NCACTIVATE', WM_NCACTIVATE);
    setMessageName('WM_GETDLGCODE', WM_GETDLGCODE);
    setMessageName('WM_NCMOUSEMOVE', WM_NCMOUSEMOVE);
    setMessageName('WM_NCLBUTTONDOWN', WM_NCLBUTTONDOWN);
    setMessageName('WM_NCLBUTTONUP', WM_NCLBUTTONUP);
    setMessageName('WM_NCLBUTTONDBLCLK', WM_NCLBUTTONDBLCLK);
    setMessageName('WM_NCRBUTTONDOWN', WM_NCRBUTTONDOWN);
    setMessageName('WM_NCRBUTTONUP', WM_NCRBUTTONUP);
    setMessageName('WM_NCRBUTTONDBLCLK', WM_NCRBUTTONDBLCLK);
    setMessageName('WM_NCMBUTTONDOWN', WM_NCMBUTTONDOWN);
    setMessageName('WM_NCMBUTTONUP', WM_NCMBUTTONUP);
    setMessageName('WM_NCMBUTTONDBLCLK', WM_NCMBUTTONDBLCLK);
    setMessageName('WM_NCXBUTTONDOWN', WM_NCXBUTTONDOWN);
    setMessageName('WM_NCXBUTTONUP', WM_NCXBUTTONUP);
    setMessageName('WM_NCXBUTTONDBLCLK', WM_NCXBUTTONDBLCLK);
    setMessageName('EM_GETSEL', EM_GETSEL);
    setMessageName('EM_SETSEL', EM_SETSEL);
    setMessageName('EM_GETRECT', EM_GETRECT);
    setMessageName('EM_SETRECT', EM_SETRECT);
    setMessageName('EM_SETRECTNP', EM_SETRECTNP);
    setMessageName('EM_SCROLL', EM_SCROLL);
    setMessageName('EM_LINESCROLL', EM_LINESCROLL);
    setMessageName('EM_SCROLLCARET', EM_SCROLLCARET);
    setMessageName('EM_GETMODIFY', EM_GETMODIFY);
    setMessageName('EM_SETMODIFY', EM_SETMODIFY);
    setMessageName('EM_GETLINECOUNT', EM_GETLINECOUNT);
    setMessageName('EM_LINEINDEX', EM_LINEINDEX);
    setMessageName('EM_SETHANDLE', EM_SETHANDLE);
    setMessageName('EM_GETHANDLE', EM_GETHANDLE);
    setMessageName('EM_GETTHUMB', EM_GETTHUMB);
    setMessageName('EM_LINELENGTH', EM_LINELENGTH);
    setMessageName('EM_REPLACESEL', EM_REPLACESEL);
    setMessageName('EM_GETLINE', EM_GETLINE);
    setMessageName('EM_LIMITTEXT', EM_LIMITTEXT);
    setMessageName('EM_SETLIMITTEXT', EM_SETLIMITTEXT);
    setMessageName('EM_CANUNDO', EM_CANUNDO);
    setMessageName('EM_UNDO', EM_UNDO);
    setMessageName('EM_FMTLINES', EM_FMTLINES);
    setMessageName('EM_LINEFROMCHAR', EM_LINEFROMCHAR);
    setMessageName('EM_SETTABSTOPS', EM_SETTABSTOPS);
    setMessageName('EM_SETPASSWORDCHAR', EM_SETPASSWORDCHAR);
    setMessageName('EM_EMPTYUNDOBUFFER', EM_EMPTYUNDOBUFFER);
    setMessageName('EM_GETFIRSTVISIBLELINE', EM_GETFIRSTVISIBLELINE);
    setMessageName('EM_SETREADONLY', EM_SETREADONLY);
    setMessageName('EM_SETWORDBREAKPROC', EM_SETWORDBREAKPROC);
    setMessageName('EM_GETWORDBREAKPROC', EM_GETWORDBREAKPROC);
    setMessageName('EM_GETPASSWORDCHAR', EM_GETPASSWORDCHAR);
    setMessageName('EM_SETMARGINS', EM_SETMARGINS);
    setMessageName('EM_GETMARGINS', EM_GETMARGINS);
    setMessageName('EM_GETLIMITTEXT', EM_GETLIMITTEXT);
    setMessageName('EM_POSFROMCHAR', EM_POSFROMCHAR);
    setMessageName('EM_CHARFROMPOS', EM_CHARFROMPOS);
    setMessageName('EM_SETIMESTATUS', EM_SETIMESTATUS);
    setMessageName('EM_GETIMESTATUS', EM_GETIMESTATUS);
    setMessageName('SBM_SETPOS', SBM_SETPOS);
    setMessageName('SBM_GETPOS', SBM_GETPOS);
    setMessageName('SBM_SETRANGE', SBM_SETRANGE);
    setMessageName('SBM_GETRANGE', SBM_GETRANGE);
    setMessageName('SBM_ENABLE_ARROWS', SBM_ENABLE_ARROWS);
    setMessageName('SBM_SETRANGEREDRAW', SBM_SETRANGEREDRAW);
    setMessageName('SBM_SETSCROLLINFO', SBM_SETSCROLLINFO);
    setMessageName('SBM_GETSCROLLINFO', SBM_GETSCROLLINFO);
    setMessageName('BM_GETCHECK', BM_GETCHECK);
    setMessageName('BM_SETCHECK', BM_SETCHECK);
    setMessageName('BM_GETSTATE', BM_GETSTATE);
    setMessageName('BM_SETSTATE', BM_SETSTATE);
    setMessageName('BM_SETSTYLE', BM_SETSTYLE);
    setMessageName('BM_CLICK', BM_CLICK);
    setMessageName('BM_GETIMAGE', BM_GETIMAGE);
    setMessageName('BM_SETIMAGE', BM_SETIMAGE);
    setMessageName('WM_INPUT', WM_INPUT);
    setMessageName('EN_SETFOCUS', EN_SETFOCUS);
    setMessageName('WM_KEYDOWN', WM_KEYDOWN);
    setMessageName('WM_KEYFIRST', WM_KEYFIRST);
    setMessageName('WM_KEYUP', WM_KEYUP);
    setMessageName('WM_CHAR', WM_CHAR);
    setMessageName('WM_DEADCHAR', WM_DEADCHAR);
    setMessageName('WM_SYSKEYDOWN', WM_SYSKEYDOWN);
    setMessageName('WM_SYSKEYUP', WM_SYSKEYUP);
    setMessageName('WM_SYSCHAR', WM_SYSCHAR);
    setMessageName('WM_SYSDEADCHAR', WM_SYSDEADCHAR);
    setMessageName('WM_KEYLAST', WM_KEYLAST);
    setMessageName('WM_UNICHAR', WM_UNICHAR);
    setMessageName('WM_IME_STARTCOMPOSITION', WM_IME_STARTCOMPOSITION);
    setMessageName('WM_IME_ENDCOMPOSITION', WM_IME_ENDCOMPOSITION);
    setMessageName('WM_IME_COMPOSITION', WM_IME_COMPOSITION);
    setMessageName('WM_IME_KEYLAST', WM_IME_KEYLAST);
    setMessageName('WM_INITDIALOG', WM_INITDIALOG);
    setMessageName('WM_COMMAND', WM_COMMAND);
    setMessageName('WM_SYSCOMMAND', WM_SYSCOMMAND);
    setMessageName('WM_TIMER', WM_TIMER);
    setMessageName('WM_HSCROLL', WM_HSCROLL);
    setMessageName('WM_VSCROLL', WM_VSCROLL);
    setMessageName('WM_INITMENU', WM_INITMENU);
    setMessageName('WM_INITMENUPOPUP', WM_INITMENUPOPUP);
    setMessageName('WM_MENUSELECT', WM_MENUSELECT);
    setMessageName('WM_MENUCHAR', WM_MENUCHAR);
    setMessageName('WM_ENTERIDLE', WM_ENTERIDLE);
    setMessageName('WM_MENURBUTTONUP', WM_MENURBUTTONUP);
    setMessageName('WM_MENUDRAG', WM_MENUDRAG);
    setMessageName('WM_MENUGETOBJECT', WM_MENUGETOBJECT);
    setMessageName('WM_UNINITMENUPOPUP', WM_UNINITMENUPOPUP);
    setMessageName('WM_MENUCOMMAND', WM_MENUCOMMAND);
    setMessageName('WM_CHANGEUISTATE', WM_CHANGEUISTATE);
    setMessageName('WM_UPDATEUISTATE', WM_UPDATEUISTATE);
    setMessageName('WM_QUERYUISTATE', WM_QUERYUISTATE);
    setMessageName('WM_CTLCOLORMSGBOX', WM_CTLCOLORMSGBOX);
    setMessageName('WM_CTLCOLOREDIT', WM_CTLCOLOREDIT);
    setMessageName('WM_CTLCOLORLISTBOX', WM_CTLCOLORLISTBOX);
    setMessageName('WM_CTLCOLORBTN', WM_CTLCOLORBTN);
    setMessageName('WM_CTLCOLORDLG', WM_CTLCOLORDLG);
    setMessageName('WM_CTLCOLORSCROLLBAR', WM_CTLCOLORSCROLLBAR);
    setMessageName('WM_CTLCOLORSTATIC', WM_CTLCOLORSTATIC);
    setMessageName('CB_GETEDITSEL', CB_GETEDITSEL);
    setMessageName('CB_LIMITTEXT', CB_LIMITTEXT);
    setMessageName('CB_SETEDITSEL', CB_SETEDITSEL);
    setMessageName('CB_ADDSTRING', CB_ADDSTRING);
    setMessageName('CB_DELETESTRING', CB_DELETESTRING);
    setMessageName('CB_DIR', CB_DIR);
    setMessageName('CB_GETCOUNT', CB_GETCOUNT);
    setMessageName('CB_GETCURSEL', CB_GETCURSEL);
    setMessageName('CB_GETLBTEXT', CB_GETLBTEXT);
    setMessageName('CB_GETLBTEXTLEN', CB_GETLBTEXTLEN);
    setMessageName('CB_INSERTSTRING', CB_INSERTSTRING);
    setMessageName('CB_RESETCONTENT', CB_RESETCONTENT);
    setMessageName('CB_FINDSTRING', CB_FINDSTRING);
    setMessageName('CB_SELECTSTRING', CB_SELECTSTRING);
    setMessageName('CB_SETCURSEL', CB_SETCURSEL);
    setMessageName('CB_SHOWDROPDOWN', CB_SHOWDROPDOWN);
    setMessageName('CB_GETITEMDATA', CB_GETITEMDATA);
    setMessageName('CB_SETITEMDATA', CB_SETITEMDATA);
    setMessageName('CB_GETDROPPEDCONTROLRECT', CB_GETDROPPEDCONTROLRECT);
    setMessageName('CB_SETITEMHEIGHT', CB_SETITEMHEIGHT);
    setMessageName('CB_GETITEMHEIGHT', CB_GETITEMHEIGHT);
    setMessageName('CB_SETEXTENDEDUI', CB_SETEXTENDEDUI);
    setMessageName('CB_GETEXTENDEDUI', CB_GETEXTENDEDUI);
    setMessageName('CB_GETDROPPEDSTATE', CB_GETDROPPEDSTATE);
    setMessageName('CB_FINDSTRINGEXACT', CB_FINDSTRINGEXACT);
    setMessageName('CB_SETLOCALE', CB_SETLOCALE);
    setMessageName('CB_GETLOCALE', CB_GETLOCALE);
    setMessageName('CB_GETTOPINDEX', CB_GETTOPINDEX);
    setMessageName('CB_SETTOPINDEX', CB_SETTOPINDEX);
    setMessageName('CB_GETHORIZONTALEXTENT', CB_GETHORIZONTALEXTENT);
    setMessageName('CB_SETHORIZONTALEXTENT', CB_SETHORIZONTALEXTENT);
    setMessageName('CB_GETDROPPEDWIDTH', CB_GETDROPPEDWIDTH);
    setMessageName('CB_SETDROPPEDWIDTH', CB_SETDROPPEDWIDTH);
    setMessageName('CB_INITSTORAGE', CB_INITSTORAGE);
    setMessageName('CB_MSGMAX', CB_MSGMAX);
    setMessageName('LB_ADDSTRING', LB_ADDSTRING);
    setMessageName('LB_INSERTSTRING', LB_INSERTSTRING);
    setMessageName('LB_DELETESTRING', LB_DELETESTRING);
    setMessageName('LB_SELITEMRANGEEX', LB_SELITEMRANGEEX);
    setMessageName('LB_RESETCONTENT', LB_RESETCONTENT);
    setMessageName('LB_SETSEL', LB_SETSEL);
    setMessageName('LB_SETCURSEL', LB_SETCURSEL);
    setMessageName('LB_GETSEL', LB_GETSEL);
    setMessageName('LB_GETCURSEL', LB_GETCURSEL);
    setMessageName('LB_GETTEXT', LB_GETTEXT);
    setMessageName('LB_GETTEXTLEN', LB_GETTEXTLEN);
    setMessageName('LB_GETCOUNT', LB_GETCOUNT);
    setMessageName('LB_SELECTSTRING', LB_SELECTSTRING);
    setMessageName('LB_DIR', LB_DIR);
    setMessageName('LB_GETTOPINDEX', LB_GETTOPINDEX);
    setMessageName('LB_FINDSTRING', LB_FINDSTRING);
    setMessageName('LB_GETSELCOUNT', LB_GETSELCOUNT);
    setMessageName('LB_GETSELITEMS', LB_GETSELITEMS);
    setMessageName('LB_SETTABSTOPS', LB_SETTABSTOPS);
    setMessageName('LB_GETHORIZONTALEXTENT', LB_GETHORIZONTALEXTENT);
    setMessageName('LB_SETHORIZONTALEXTENT', LB_SETHORIZONTALEXTENT);
    setMessageName('LB_SETCOLUMNWIDTH', LB_SETCOLUMNWIDTH);
    setMessageName('LB_ADDFILE', LB_ADDFILE);
    setMessageName('LB_SETTOPINDEX', LB_SETTOPINDEX);
    setMessageName('LB_GETITEMRECT', LB_GETITEMRECT);
    setMessageName('LB_GETITEMDATA', LB_GETITEMDATA);
    setMessageName('LB_SETITEMDATA', LB_SETITEMDATA);
    setMessageName('LB_SELITEMRANGE', LB_SELITEMRANGE);
    setMessageName('LB_SETANCHORINDEX', LB_SETANCHORINDEX);
    setMessageName('LB_GETANCHORINDEX', LB_GETANCHORINDEX);
    setMessageName('LB_SETCARETINDEX', LB_SETCARETINDEX);
    setMessageName('LB_GETCARETINDEX', LB_GETCARETINDEX);
    setMessageName('LB_SETITEMHEIGHT', LB_SETITEMHEIGHT);
    setMessageName('LB_GETITEMHEIGHT', LB_GETITEMHEIGHT);
    setMessageName('LB_FINDSTRINGEXACT', LB_FINDSTRINGEXACT);
    setMessageName('LB_SETLOCALE', LB_SETLOCALE);
    setMessageName('LB_GETLOCALE', LB_GETLOCALE);
    setMessageName('LB_SETCOUNT', LB_SETCOUNT);
    setMessageName('LB_INITSTORAGE', LB_INITSTORAGE);
    setMessageName('LB_ITEMFROMPOINT', LB_ITEMFROMPOINT);
    setMessageName('LB_MSGMAX', LB_MSGMAX);
    setMessageName('EN_KILLFOCUS', EN_KILLFOCUS);
    setMessageName('WM_MOUSEFIRST', WM_MOUSEFIRST);
    setMessageName('WM_MOUSEMOVE', WM_MOUSEMOVE);
    setMessageName('WM_LBUTTONDOWN', WM_LBUTTONDOWN);
    setMessageName('WM_LBUTTONUP', WM_LBUTTONUP);
    setMessageName('WM_LBUTTONDBLCLK', WM_LBUTTONDBLCLK);
    setMessageName('WM_RBUTTONDOWN', WM_RBUTTONDOWN);
    setMessageName('WM_RBUTTONUP', WM_RBUTTONUP);
    setMessageName('WM_RBUTTONDBLCLK', WM_RBUTTONDBLCLK);
    setMessageName('WM_MBUTTONDOWN', WM_MBUTTONDOWN);
    setMessageName('WM_MBUTTONUP', WM_MBUTTONUP);
    setMessageName('WM_MBUTTONDBLCLK', WM_MBUTTONDBLCLK);
    setMessageName('WM_MOUSELAST', WM_MOUSELAST);
    setMessageName('WM_MOUSEWHEEL', WM_MOUSEWHEEL);
    setMessageName('WM_PARENTNOTIFY', WM_PARENTNOTIFY);
    setMessageName('WM_ENTERMENULOOP', WM_ENTERMENULOOP);
    setMessageName('WM_EXITMENULOOP', WM_EXITMENULOOP);
    setMessageName('WM_NEXTMENU', WM_NEXTMENU);
    setMessageName('WM_SIZING', WM_SIZING);
    setMessageName('WM_CAPTURECHANGED', WM_CAPTURECHANGED);
    setMessageName('WM_MOVING', WM_MOVING);
    setMessageName('WM_POWERBROADCAST', WM_POWERBROADCAST);
    setMessageName('WM_DEVICECHANGE', WM_DEVICECHANGE);
    setMessageName('WM_MDICREATE', WM_MDICREATE);
    setMessageName('WM_MDIDESTROY', WM_MDIDESTROY);
    setMessageName('WM_MDIACTIVATE', WM_MDIACTIVATE);
    setMessageName('WM_MDIRESTORE', WM_MDIRESTORE);
    setMessageName('WM_MDINEXT', WM_MDINEXT);
    setMessageName('WM_MDIMAXIMIZE', WM_MDIMAXIMIZE);
    setMessageName('WM_MDITILE', WM_MDITILE);
    setMessageName('WM_MDICASCADE', WM_MDICASCADE);
    setMessageName('WM_MDIICONARRANGE', WM_MDIICONARRANGE);
    setMessageName('WM_MDIGETACTIVE', WM_MDIGETACTIVE);
    setMessageName('WM_MDISETMENU', WM_MDISETMENU);
    setMessageName('WM_ENTERSIZEMOVE', WM_ENTERSIZEMOVE);
    setMessageName('WM_EXITSIZEMOVE', WM_EXITSIZEMOVE);
    setMessageName('WM_DROPFILES', WM_DROPFILES);
    setMessageName('WM_MDIREFRESHMENU', WM_MDIREFRESHMENU);
    setMessageName('WM_IME_SETCONTEXT', WM_IME_SETCONTEXT);
    setMessageName('WM_IME_NOTIFY', WM_IME_NOTIFY);
    setMessageName('WM_IME_CONTROL', WM_IME_CONTROL);
    setMessageName('WM_IME_COMPOSITIONFULL', WM_IME_COMPOSITIONFULL);
    setMessageName('WM_IME_SELECT', WM_IME_SELECT);
    setMessageName('WM_IME_CHAR', WM_IME_CHAR);
    setMessageName('WM_IME_REQUEST', WM_IME_REQUEST);
    setMessageName('WM_IME_KEYDOWN', WM_IME_KEYDOWN);
    setMessageName('WM_IME_KEYUP', WM_IME_KEYUP);
    setMessageName('WM_NCMOUSEHOVER', WM_NCMOUSEHOVER);
    setMessageName('WM_MOUSEHOVER', WM_MOUSEHOVER);
    setMessageName('WM_NCMOUSELEAVE', WM_NCMOUSELEAVE);
    setMessageName('WM_MOUSELEAVE', WM_MOUSELEAVE);
    setMessageName('WM_WTSSESSION_CHANGE', WM_WTSSESSION_CHANGE);
    setMessageName('WM_TABLET_FIRST', WM_TABLET_FIRST);
    setMessageName('WM_TABLET_LAST', WM_TABLET_LAST);
    setMessageName('EN_CHANGE', EN_CHANGE);
    setMessageName('WM_CUT', WM_CUT);
    setMessageName('WM_COPY', WM_COPY);
    setMessageName('WM_PASTE', WM_PASTE);
    setMessageName('WM_CLEAR', WM_CLEAR);
    setMessageName('WM_UNDO', WM_UNDO);
    setMessageName('WM_RENDERFORMAT', WM_RENDERFORMAT);
    setMessageName('WM_RENDERALLFORMATS', WM_RENDERALLFORMATS);
    setMessageName('WM_DESTROYCLIPBOARD', WM_DESTROYCLIPBOARD);
    setMessageName('WM_DRAWCLIPBOARD', WM_DRAWCLIPBOARD);
    setMessageName('WM_PAINTCLIPBOARD', WM_PAINTCLIPBOARD);
    setMessageName('WM_VSCROLLCLIPBOARD', WM_VSCROLLCLIPBOARD);
    setMessageName('WM_SIZECLIPBOARD', WM_SIZECLIPBOARD);
    setMessageName('WM_ASKCBFORMATNAME', WM_ASKCBFORMATNAME);
    setMessageName('WM_CHANGECBCHAIN', WM_CHANGECBCHAIN);
    setMessageName('WM_HSCROLLCLIPBOARD', WM_HSCROLLCLIPBOARD);
    setMessageName('WM_QUERYNEWPALETTE', WM_QUERYNEWPALETTE);
    setMessageName('WM_PALETTEISCHANGING', WM_PALETTEISCHANGING);
    setMessageName('WM_PALETTECHANGED', WM_PALETTECHANGED);
    setMessageName('WM_HOTKEY', WM_HOTKEY);
    setMessageName('WM_PRINT', WM_PRINT);
    setMessageName('WM_PRINTCLIENT', WM_PRINTCLIENT);
    setMessageName('WM_APPCOMMAND', WM_APPCOMMAND);
    setMessageName('WM_THEMECHANGED', WM_THEMECHANGED);
    setMessageName('WM_DWMCOMPOSITIONCHANGED', WM_DWMCOMPOSITIONCHANGED);
    setMessageName('WM_DWMNCRENDERINGCHANGED', WM_DWMNCRENDERINGCHANGED);
    setMessageName('WM_DWMCOLORIZATIONCOLORCHANGED', WM_DWMCOLORIZATIONCOLORCHANGED);
    setMessageName('WM_DWMWINDOWMAXIMIZEDCHANGE', WM_DWMWINDOWMAXIMIZEDCHANGE);
    setMessageName('WM_HANDHELDFIRST', WM_HANDHELDFIRST);
    setMessageName('WM_HANDHELDLAST', WM_HANDHELDLAST);
    setMessageName('WM_PENWINFIRST', WM_PENWINFIRST);
    setMessageName('WM_PENWINLAST', WM_PENWINLAST);
    setMessageName('WM_COALESCE_FIRST', WM_COALESCE_FIRST);
    setMessageName('WM_COALESCE_LAST', WM_COALESCE_LAST);
    setMessageName('WM_DDE_FIRST', WM_DDE_FIRST);
    setMessageName('WM_DDE_INITIATE', WM_DDE_INITIATE);
    setMessageName('WM_DDE_TERMINATE', WM_DDE_TERMINATE);
    setMessageName('WM_DDE_ADVISE', WM_DDE_ADVISE);
    setMessageName('WM_DDE_UNADVISE', WM_DDE_UNADVISE);
    setMessageName('WM_DDE_ACK', WM_DDE_ACK);
    setMessageName('WM_DDE_DATA', WM_DDE_DATA);
    setMessageName('WM_DDE_REQUEST', WM_DDE_REQUEST);
    setMessageName('WM_DDE_POKE', WM_DDE_POKE);
    setMessageName('WM_DDE_EXECUTE', WM_DDE_EXECUTE);
    setMessageName('WM_DDE_LAST', WM_DDE_LAST);
    setMessageName('DM_GETDEFID', DM_GETDEFID);
    setMessageName('EN_UPDATE', EN_UPDATE);
    setMessageName('WM_USER', WM_USER);
    setMessageName('DM_SETDEFID', DM_SETDEFID);
    setMessageName('DM_REPOSITION', DM_REPOSITION);
    setMessageName('PSM_PAGEINFO', PSM_PAGEINFO);
    setMessageName('PSM_SHEETINFO', PSM_SHEETINFO);
    setMessageName('EN_ERRSPACE', EN_ERRSPACE);
    setMessageName('EN_MAXTEXT', EN_MAXTEXT);
    setMessageName('EN_HSCROLL', EN_HSCROLL);
    setMessageName('EN_VSCROLL', EN_VSCROLL);
    setMessageName('WM_APP', WM_APP);
    setMessageName('CM_ACTIVATE', CM_ACTIVATE);
    setMessageName('CM_BASE', CM_BASE);
    setMessageName('CM_DEACTIVATE', CM_DEACTIVATE);
    setMessageName('CM_GOTFOCUS', CM_GOTFOCUS);
    setMessageName('CM_LOSTFOCUS', CM_LOSTFOCUS);
    setMessageName('CM_CANCELMODE', CM_CANCELMODE);
    setMessageName('CM_DIALOGKEY', CM_DIALOGKEY);
    setMessageName('CM_DIALOGCHAR', CM_DIALOGCHAR);
    setMessageName('CM_FOCUSCHANGED', CM_FOCUSCHANGED);
    setMessageName('CM_PARENTFONTCHANGED', CM_PARENTFONTCHANGED);
    setMessageName('CM_PARENTCOLORCHANGED', CM_PARENTCOLORCHANGED);
    setMessageName('CM_HITTEST', CM_HITTEST);
    setMessageName('CM_VISIBLECHANGED', CM_VISIBLECHANGED);
    setMessageName('CM_ENABLEDCHANGED', CM_ENABLEDCHANGED);
    setMessageName('CM_COLORCHANGED', CM_COLORCHANGED);
    setMessageName('CM_FONTCHANGED', CM_FONTCHANGED);
    setMessageName('CM_CURSORCHANGED', CM_CURSORCHANGED);
    setMessageName('CM_CTL3DCHANGED', CM_CTL3DCHANGED);
    setMessageName('CM_PARENTCTL3DCHANGED', CM_PARENTCTL3DCHANGED);
    setMessageName('CM_TEXTCHANGED', CM_TEXTCHANGED);
    setMessageName('CM_MOUSEENTER', CM_MOUSEENTER);
    setMessageName('CM_MOUSELEAVE', CM_MOUSELEAVE);
    setMessageName('CM_MENUCHANGED', CM_MENUCHANGED);
    setMessageName('CM_APPKEYDOWN', CM_APPKEYDOWN);
    setMessageName('CM_APPSYSCOMMAND', CM_APPSYSCOMMAND);
    setMessageName('CM_BUTTONPRESSED', CM_BUTTONPRESSED);
    setMessageName('CM_SHOWINGCHANGED', CM_SHOWINGCHANGED);
    setMessageName('CM_ENTER', CM_ENTER);
    setMessageName('CM_EXIT', CM_EXIT);
    setMessageName('CM_DESIGNHITTEST', CM_DESIGNHITTEST);
    setMessageName('CM_ICONCHANGED', CM_ICONCHANGED);
    setMessageName('CM_WANTSPECIALKEY', CM_WANTSPECIALKEY);
    setMessageName('CM_INVOKEHELP', CM_INVOKEHELP);
    setMessageName('CM_WINDOWHOOK', CM_WINDOWHOOK);
    setMessageName('CM_RELEASE', CM_RELEASE);
    setMessageName('CM_SHOWHINTCHANGED', CM_SHOWHINTCHANGED);
    setMessageName('CM_PARENTSHOWHINTCHANGED', CM_PARENTSHOWHINTCHANGED);
    setMessageName('CM_SYSCOLORCHANGE', CM_SYSCOLORCHANGE);
    setMessageName('CM_WININICHANGE', CM_WININICHANGE);
    setMessageName('CM_FONTCHANGE', CM_FONTCHANGE);
    setMessageName('CM_TIMECHANGE', CM_TIMECHANGE);
    setMessageName('CM_TABSTOPCHANGED', CM_TABSTOPCHANGED);
    setMessageName('CM_UIACTIVATE', CM_UIACTIVATE);
    setMessageName('CM_UIDEACTIVATE', CM_UIDEACTIVATE);
    setMessageName('CM_DOCWINDOWACTIVATE', CM_DOCWINDOWACTIVATE);
    setMessageName('CM_CONTROLLISTCHANGE', CM_CONTROLLISTCHANGE);
    setMessageName('CM_GETDATALINK', CM_GETDATALINK);
    setMessageName('CM_CHILDKEY', CM_CHILDKEY);
    setMessageName('CM_DRAG', CM_DRAG);
    setMessageName('CM_HINTSHOW', CM_HINTSHOW);
    setMessageName('CM_DIALOGHANDLE', CM_DIALOGHANDLE);
    setMessageName('CM_ISTOOLCONTROL', CM_ISTOOLCONTROL);
    setMessageName('CM_RECREATEWND', CM_RECREATEWND);
    setMessageName('CM_INVALIDATE', CM_INVALIDATE);
    setMessageName('CM_SYSFONTCHANGED', CM_SYSFONTCHANGED);
    setMessageName('CM_CONTROLCHANGE', CM_CONTROLCHANGE);
    setMessageName('CM_CHANGED', CM_CHANGED);
    setMessageName('CM_DOCKCLIENT', CM_DOCKCLIENT);
    setMessageName('CM_UNDOCKCLIENT', CM_UNDOCKCLIENT);
    setMessageName('CM_FLOAT', CM_FLOAT);
    setMessageName('CM_BORDERCHANGED', CM_BORDERCHANGED);
    setMessageName('CM_BIDIMODECHANGED', CM_BIDIMODECHANGED);
    setMessageName('CM_PARENTBIDIMODECHANGED', CM_PARENTBIDIMODECHANGED);
    setMessageName('CM_ALLCHILDRENFLIPPED', CM_ALLCHILDRENFLIPPED);
    setMessageName('CM_ACTIONUPDATE', CM_ACTIONUPDATE);
    setMessageName('CM_ACTIONEXECUTE', CM_ACTIONEXECUTE);
    setMessageName('CM_HINTSHOWPAUSE', CM_HINTSHOWPAUSE);
    setMessageName('CM_DOCKNOTIFICATION', CM_DOCKNOTIFICATION);
    setMessageName('CM_MOUSEWHEEL', CM_MOUSEWHEEL);
    setMessageName('CM_ISSHORTCUT', CM_ISSHORTCUT);
    setMessageName('CM_INVALIDATEDOCKHOST', CM_INVALIDATEDOCKHOST);
    setMessageName('CM_SETACTIVECONTROL', CM_SETACTIVECONTROL);
    setMessageName('CM_POPUPHWNDDESTROY', CM_POPUPHWNDDESTROY);
    setMessageName('CM_CREATEPOPUP', CM_CREATEPOPUP);
    setMessageName('CM_DESTROYHANDLE', CM_DESTROYHANDLE);
    setMessageName('CM_MOUSEACTIVATE', CM_MOUSEACTIVATE);
    setMessageName('CM_CONTROLLISTCHANGING', CM_CONTROLLISTCHANGING);
    setMessageName('CM_BUFFEREDPRINTCLIENT', CM_BUFFEREDPRINTCLIENT);
    setMessageName('CM_UNTHEMECONTROL', CM_UNTHEMECONTROL);
    setMessageName('CN_BASE', CN_BASE);
    setMessageName('CN_DRAWITEM', CN_DRAWITEM);
    setMessageName('CN_MEASUREITEM', CN_MEASUREITEM);
    setMessageName('CN_DELETEITEM', CN_DELETEITEM);
    setMessageName('CN_VKEYTOITEM', CN_VKEYTOITEM);
    setMessageName('CN_CHARTOITEM', CN_CHARTOITEM);
    setMessageName('CN_COMPAREITEM', CN_COMPAREITEM);
    setMessageName('CN_NOTIFY', CN_NOTIFY);
    setMessageName('CN_KEYDOWN', CN_KEYDOWN);
    setMessageName('CN_KEYUP', CN_KEYUP);
    setMessageName('CN_CHAR', CN_CHAR);
    setMessageName('CN_SYSKEYDOWN', CN_SYSKEYDOWN);
    setMessageName('CN_SYSCHAR', CN_SYSCHAR);
    setMessageName('CN_COMMAND', CN_COMMAND);
    setMessageName('CN_HSCROLL', CN_HSCROLL);
    setMessageName('CN_VSCROLL', CN_VSCROLL);
    setMessageName('CN_CTLCOLORMSGBOX', CN_CTLCOLORMSGBOX);
    setMessageName('CN_CTLCOLOREDIT', CN_CTLCOLOREDIT);
    setMessageName('CN_CTLCOLORLISTBOX', CN_CTLCOLORLISTBOX);
    setMessageName('CN_CTLCOLORBTN', CN_CTLCOLORBTN);
    setMessageName('CN_CTLCOLORDLG', CN_CTLCOLORDLG);
    setMessageName('CN_CTLCOLORSCROLLBAR', CN_CTLCOLORSCROLLBAR);
    setMessageName('CN_CTLCOLORSTATIC', CN_CTLCOLORSTATIC);
    setMessageName('CN_PARENTNOTIFY', CN_PARENTNOTIFY);
  end;
begin
  if GMessageName[Low(GMessageName)] = '' then
    InitMessageName;

  if (AMessage < Low(GMessageName)) or (AMessage > High(GMessageName)) then
  begin
    Result := Format('Unknown(%d)(0x%x)', [AMessage, AMessage]);
    Exit;
  end;

  Result := Format('%s(%d)(0x%x)', [GMessageName[AMessage], AMessage, AMessage]);
end;

end.
