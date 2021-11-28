#include "stdafx.h"
#include "resource.h"
#include <OAIdl.h>
#include "IDL/ETS.h"
#include "ATL/InterfaceImplement.h"
#include "ATL/Utility.h"
#include "IDL/IModule.h"
#include "Python.h"
#include "V8.h"
//打开注释后，会自动根据msscript中的类型库信息，在输出目录中生成接口定义头文件
//#import "E:/Tool/ETS/Common/msscript.ocx" no_namespace raw_interfaces_only no_smart_pointers
#include "JScript.h"

class CModule:
    public vcl4c::itf::CDispatch<ATL::CComMultiThreadModel>,
    public IModule
{
    BEGIN_DEFINE_MAP(CModule)
        SIMPLE_INTERFACE(IDispatch)
        SIMPLE_INTERFACE(IModule)
    END_DEFINE_MAP()

    IMPLEMENT_IUNKNOWN()

    enum {IDL = IDTL_MODULE};

public:
    CModule()
        : CDispatch(IDL, &__uuidof(IModule), NULL)
    {
    }

    virtual ~CModule()
    {
    }

    HRESULT Init()
    {
        return S_OK;
    }

public:
    //IModule实现
    STDMETHOD(GetPython)(IDispatch** p_itfResult)
    {
        return vcl4c::itf::ObjectToDispatch<ets::python::CPython>(p_itfResult, new (std::nothrow) ets::python::CPython());
    }

    STDMETHOD(GetV8)(IDispatch** p_itfResult)
    {
        return vcl4c::itf::ObjectToDispatch<ets::v8::CV8>(p_itfResult, new (std::nothrow) ets::v8::CV8());
    }

    STDMETHOD(GetJScript)(IDispatch** p_itfResult)
    {
        return vcl4c::itf::ObjectToDispatch<ets::jscript::CJScript>(p_itfResult, new (std::nothrow) ets::jscript::CJScript());
    }

};

STDAPI GetModule(IManager *p_itfManager, IDispatch **p_itfResult)
{
    vcl4c::itf::CManager::InitManager(p_itfManager);
    return vcl4c::itf::ObjectToDispatch<CModule>(p_itfResult, new (std::nothrow) CModule());
}

BOOL APIENTRY DllMain(HMODULE p_hModule, DWORD  p_iReason, LPVOID p_pReserved)
{
    switch (p_iReason)
    {
    case DLL_PROCESS_ATTACH:
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
        break;
    case DLL_PROCESS_DETACH:
        vcl4c::itf::CManager::InitManager(nullptr);
        ets::jscript::CJScript::UnLoad();
        break;
    }

    return TRUE;
}
