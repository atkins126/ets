#pragma once

#include <Windows.h>

#ifdef USE64
    #define is_x64 1
#else
    #define is_x64 0
#endif//USE64

#define F_INVALID       0x01
#define F_PREFIX        0x02
#define F_REX           0x04
#define F_MODRM         0x08
#define F_SIB           0x10
#define F_DISP          0x20
#define F_IMM           0x40
#define F_RELATIVE      0x80

struct CAddress
{
    BYTE m_iOffset;
    BYTE m_iSize;
};

struct DasmData
{
    BYTE m_iFlags;
    BYTE m_iRex;
    CAddress m_stOpcode;
    BYTE m_iModRM;
    BYTE m_iSIB;
    CAddress m_stDisplacement;
    CAddress m_stImmediate;
};

int Dasm(DasmData *p_ddDasmData, const BYTE *p_pCode, const bool p_bX64);
