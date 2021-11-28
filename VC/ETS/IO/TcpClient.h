#pragma once

#include "resource.h"
#include "IDL/ITCPClient.h"
#include <memory>
#include <boost/asio.hpp>
#include "Handler/TcpHandler.h"

namespace ets
{
    namespace io
    {
        class CTcpClient:
            public vcl4c::itf::CDispatch<ATL::CComMultiThreadModel>,
            public ITcpClient
        {
            BEGIN_DEFINE_MAP(CTcpClient)
                SIMPLE_INTERFACE(IDispatch)
                SIMPLE_INTERFACE(ITcpClient)
            END_DEFINE_MAP()

            IMPLEMENT_IUNKNOWN()

            enum {IDL = IDTL_TCPCLIENT};

        public:
            CTcpClient(boost::asio::io_service &p_iosService, const std::string p_sHost, const std::string p_sService)
                : CDispatch(IDL, &__uuidof(ITcpClient), NULL),
                m_socConnection(new CTcpSocket(p_iosService)), m_sHost(p_sHost), m_sService(p_sService)
            {
            }

            virtual ~CTcpClient()
            {
                m_socConnection->Close();
            }

            HRESULT Init()
            {
                m_socConnection->Connect(boost::asio::ip::tcp::resolver::query(m_sHost, m_sService));

                return S_OK;
            }

        public:
            //ITCPClientÊµÏÖ
            STDMETHOD(Write)(BSTR p_sValue)
            {
                HRESULT hRes = S_OK;

                std::string sValue;
                hRes = vcl4c::itf::W2String(sValue, p_sValue);
                if (FAILED(hRes))
                {
                    return hRes;
                }

                m_socConnection->Write(reinterpret_cast<const unsigned char *>(sValue.c_str()), sValue.size());

                return S_OK;
            }

        private:
            std::string m_sHost, m_sService;
            boost::shared_ptr<CTcpSocket> m_socConnection;

        };
    }
}
