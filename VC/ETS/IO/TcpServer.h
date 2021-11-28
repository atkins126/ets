#pragma once

#include "resource.h"
#include "IDL/ITCPServer.h"
#include <boost/asio.hpp>
#include <boost/bind.hpp>
#include "Handler/TcpHandler.h"

namespace ets
{
    namespace io
    {
        class CTcpServer:
            public vcl4c::itf::CDispatch<ATL::CComMultiThreadModel>,
            public ITcpServer
        {
            BEGIN_DEFINE_MAP(CTcpServer)
                SIMPLE_INTERFACE(IDispatch)
                SIMPLE_INTERFACE(ITcpServer)
            END_DEFINE_MAP()

            IMPLEMENT_IUNKNOWN()

            enum {IDL = IDTL_TCPSERVER};

        public:
            CTcpServer(boost::asio::io_service &p_iosService, const std::string &p_sHost, const std::string &p_sService)
                : CDispatch(IDL, &__uuidof(ITcpServer), NULL),
                m_socAcceptor(new boost::asio::ip::tcp::acceptor(p_iosService)), m_sHost(p_sHost), m_sService(p_sService)
            {
            }

            virtual ~CTcpServer()
            {
            }

            HRESULT Init()
            {
                //1.0 解析地址
                boost::asio::ip::tcp::resolver res(m_socAcceptor->get_io_service());
                boost::asio::ip::tcp::resolver::query qry(m_sHost, m_sService);

                boost::system::error_code ec;
                boost::asio::ip::tcp::endpoint ep = *res.resolve(qry, ec);
                if (ec)
                {
                    return E_INVALIDARG;
                }

                //2.0 初始化监听socket
                m_socAcceptor->open(ep.protocol(), ec);
                if (ec)
                {
                    return E_INVALIDARG;
                }

                m_socAcceptor->set_option(boost::asio::ip::tcp::acceptor::reuse_address(true), ec);
                if (ec)
                {
                    return E_INVALIDARG;
                }

                m_socAcceptor->bind(ep, ec);
                if (ec)
                {
                    return E_INVALIDARG;
                }

                m_socAcceptor->listen(boost::asio::socket_base::max_connections, ec);
                if (ec)
                {
                    return E_INVALIDARG;
                }

                //3.0 监听连接
                boost::shared_ptr<ets::io::CTcpSocket> socConnection(new ets::io::CTcpSocket(m_socAcceptor->get_io_service()));
                socConnection->Accept(m_socAcceptor);

                return S_OK;
            }

        public:
            //ITCPServer实现

        private:
            std::string m_sHost, m_sService;
            boost::shared_ptr<boost::asio::ip::tcp::acceptor> m_socAcceptor;

        };
    }
}
