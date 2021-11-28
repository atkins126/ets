#pragma once

#include <OAIdl.h>
#include "Handler.h"
#include "ATL/Utility.h"

namespace ets
{
    namespace io
    {
        class CJsHandler
            : public CHandler
        {
        public:
            CJsHandler()
                : m_itfCallback(nullptr)
            {
            }

            explicit CJsHandler(IDispatch *p_itfCallback)
                : m_itfCallback(nullptr)
            {
                Bind(p_itfCallback);
            }

            ~CJsHandler()
            {
                Clear();
            }

            void Bind(IDispatch *p_itfCallback)
            {
                if (m_itfCallback == p_itfCallback)
                {
                    return;
                }

                Clear();

                m_itfCallback = p_itfCallback;
                if (nullptr != m_itfCallback)
                {
                    m_itfCallback->AddRef();
                }
            }

            void Clear()
            {
                if (nullptr != m_itfCallback)
                {
                    m_itfCallback->Release();
                    m_itfCallback = nullptr;
                }
            }

        public:
            //组件链接口实现
            bool DoPush(const std::string &p_sLine)
            {
                if (nullptr != m_itfCallback)
                {
                    CComVariant vResult;
                    return SUCCEEDED(vcl4c::itf::CDispatchHelper::DispatchInvoke(m_itfCallback,
                        0L, DISPATCH_METHOD, &vResult, "s", p_sLine.c_str()));
                }

                return true;
            }

            bool DoClose()
            {
                return true;
            }

            bool DoPull()
            {
                return true;
            }

        private:
            IDispatch *m_itfCallback;

        };
    }
}
