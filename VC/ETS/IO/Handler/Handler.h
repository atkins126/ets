#pragma once

#include <bind/auto_bind.hpp>

namespace ets
{
    namespace io
    {
        class CHandler
        {
        public:
            template<typename COnCallback>
            void BindClose(const COnCallback p_onCallback)
            {
                class CCallback
                    : public IOnEvent
                {
                public:
                    CCallback(const COnCallback p_onCallBack)
                        : m_onCallBack(p_onCallBack)
                    {
                    }

                    bool Call()
                    {
                        return m_onCallBack();
                    }

                private:
                    COnCallback m_onCallBack;
                };

                m_spOnClose.reset(new CCallback(p_onCallback));
            }

            template<typename COnCallback>
            void BindPull(const COnCallback p_onCallback)
            {
                class CCallback
                    : public IOnEvent
                {
                public:
                    CCallback(const COnCallback p_onCallBack)
                        : m_onCallBack(p_onCallBack)
                    {
                    }

                    bool Call()
                    {
                        return m_onCallBack();
                    }

                private:
                    COnCallback m_onCallBack;
                };

                m_spOnPull.reset(new CCallback(p_onCallback));
            }

        protected:
            bool NextClose()
            {
                if (m_spOnClose)
                {
                    return m_spOnClose->Call();
                }

                return true;
            }

            bool PreviousPull()
            {
                if (m_spOnPull)
                {
                    return m_spOnPull->Call();
                }

                return true;
            }

        private:
            struct IOnEvent
            {
                virtual bool Call() = 0;
            };

            boost::shared_ptr<IOnEvent> m_spOnClose;
            boost::shared_ptr<IOnEvent> m_spOnPull;

        };

        struct CBind
        {
            template<typename CFirst, typename CNext>
            void operator ()(CFirst &p_First, CNext &p_Next) const
            {
                p_First.BindPush(ets::auto_bind(&CNext::DoPush, &p_Next));
                p_First.BindClose(ets::auto_bind(&CNext::DoClose, &p_Next));

                p_Next.BindPull(ets::auto_bind(&CFirst::DoPull, &p_First));
            }
        };
    }
}
