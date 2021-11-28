#pragma once

#include "resource.h"
#include "IDL/IScript.h"

namespace ets
{
    namespace v8
    {
        class CV8:
            public vcl4c::itf::CDispatch<ATL::CComMultiThreadModel>,
            public IScript
        {
            BEGIN_DEFINE_MAP(CV8)
                SIMPLE_INTERFACE(IDispatch)
                SIMPLE_INTERFACE(IScript)
            END_DEFINE_MAP()

            IMPLEMENT_IUNKNOWN()

            enum {IDL = IDTL_SCRIPT};

        public:
            CV8()
                : CDispatch(IDL, &__uuidof(IScript), NULL)
            {
            }

            virtual ~CV8()
            {
            }

            HRESULT Init()
            {
                return S_OK;
            }

        public:
            //IScript实现
            STDMETHOD(RegContainer)(IDispatch* p_itfContainer)
            {
                // TODO: 在此添加实现代码

                return S_OK;
            }

            STDMETHOD(RegFrame)(IDispatch* p_itfFrame)
            {
                // TODO: 在此添加实现代码

                return S_OK;
            }

            STDMETHOD(RunModule)(BSTR p_sFileName, BSTR p_sEntryFunction)
            {
                // TODO: 在此添加实现代码

                return S_OK;
            }

            STDMETHOD(RunCode)(BSTR p_sCode)
            {
                // TODO: 在此添加实现代码

                return S_OK;
            }

        };

    }
}
