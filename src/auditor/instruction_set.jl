## We start with definitions of instruction mnemonics, broken down by category:
instruction_categories = Dict(
    # These are mnemonics that we purposefully aren't going to classify.
    # Also, this initializes an "unknown" category for us, which is nice.
    "unknown" => String[
        "hlt",
    ],
    # We might want to know if this binary does CPUID detection
    "cpuid" => String[
        "cpuid",
    ],
    "nop" => String[
        "nop",
    ],
    "call" => String[
        "call",
        "callq",
    ],
    "486" => String[
        "bswap",
        "cmpxchg",
        "invd",
        "invlpg",
        "wbinvd",
        "xadd",
    ],
    "586" => String[
        "cmpxchg8b",
        "rdmsr",
        "rdtsc",
        "wrmsr",
    ],
    "686" => String[
        "cmova",
        "cmovae",
        "cmovb",
        "cmovbe",
        "cmovc",
        "cmove",
        "cmovg",
        "cmovge",
        "cmovl",
        "cmovle",
        "cmovna",
        "cmovnae",
        "cmovnb",
        "cmovnbe",
        "cmovnc",
        "cmovne",
        "cmovng",
        "cmovnge",
        "cmovnl",
        "cmovnle",
        "cmovno",
        "cmovnp",
        "cmovns",
        "cmovnz",
        "cmovo",
        "cmovp",
        "cmovs",
        "cmovz",
        "fcmova",
        "fcmovae",
        "fcmovb",
        "fcmovbe",
        "fcmove",
        "fcmovna",
        "fcmovnae",
        "fcmovnb",
        "fcmovnbe",
        "fcmovne",
        "fcmovnu",
        "fcmovu",
        "fcomi",
        "fcomip",
        "fcompi",
        "fucomi",
        "fucomip",
        "fucompi",
        "fxrstor",
        "fxsave",
        "rdpmc",
        "sysenter",
        "sysexit",
        "ud2",
        "ud2a",
        "ud2b",
    ],
    "mmx" => String[
        "emms",
        "movd",
        "movq",
        "packssdw",
        "packsswb",
        "packuswb",
        "paddb",
        "paddd",
        "paddsb",
        "paddsw",
        "paddusb",
        "paddusw",
        "paddw",
        "pand",
        "pandn",
        "pcmpeqb",
        "pcmpeqd",
        "pcmpeqw",
        "pcmpgtb",
        "pcmpgtd",
        "pcmpgtw",
        "pmaddwd",
        "pmulhw",
        "pmullw",
        "por",
        "pslld",
        "psllq",
        "psllw",
        "psrad",
        "psraw",
        "psrld",
        "psrlq",
        "psrlw",
        "psubb",
        "psubd",
        "psubsb",
        "psubsw",
        "psubusb",
        "psubusw",
        "psubw",
        "punpckhbw",
        "punpckhdq",
        "punpckhwd",
        "punpcklbw",
        "punpckldq",
        "punpcklwd",
        "pxor",
    ],
    "sse" => String[
        "addps",
        "addss",
        "andnps",
        "andps",
        "cmpeqps",
        "cmpeqss",
        "cmpleps",
        "cmpless",
        "cmpltps",
        "cmpltss",
        "cmpneqps",
        "cmpneqss",
        "cmpnleps",
        "cmpnless",
        "cmpnltps",
        "cmpnltss",
        "cmpordps",
        "cmpordss",
        "cmpps",
        "cmpss",
        "cmpunordps",
        "cmpunordss",
        "comiss",
        "cvtpi2ps",
        "cvtps2pi",
        "cvtsi2ss",
        "cvtss2si",
        "cvttps2pi",
        "cvttss2si",
        "divps",
        "divss",
        "ldmxcsr",
        "maskmovq",
        "maxps",
        "maxss",
        "minps",
        "minss",
        "movaps",
        "movhlps",
        "movhps",
        "movlhps",
        "movlps",
        "movmskps",
        "movntps",
        "movntq",
        "movss",
        "movups",
        "mulps",
        "mulss",
        "orps",
        "pavgb",
        "pavgw",
        "pextrw",
        "pinsrw",
        "pmaxsw",
        "pmaxub",
        "pminsw",
        "pminub",
        "pmovmskb",
        "pmulhuw",
        "prefetchnta",
        "prefetcht0",
        "prefetcht1",
        "prefetcht2",
        "psadbw",
        "pshufw",
        "rcpps",
        "rcpss",
        "rsqrtps",
        "rsqrtss",
        "sfence",
        "shufps",
        "sqrtps",
        "sqrtss",
        "stmxcsr",
        "subps",
        "subss",
        "ucomiss",
        "unpckhps",
        "unpcklps",
        "xorps",
    ],
    "sse2" => String[
        "addpd",
        "addsd",
        "andnpd",
        "andpd",
        "clflush",
        "cmpeqpd",
        "cmpeqsd",
        "cmplepd",
        "cmplesd",
        "cmpltpd",
        "cmpltsd",
        "cmpneqpd",
        "cmpneqsd",
        "cmpnlepd",
        "cmpnlesd",
        "cmpnltpd",
        "cmpnltsd",
        "cmpordpd",
        "cmpordsd",
        "cmppd",
        "cmpsd",
        "cmpunordpd",
        "cmpunordsd",
        "comisd",
        "cvtdq2pd",
        "cvtdq2ps",
        "cvtpd2dq",
        "cvtpd2pi",
        "cvtpd2ps",
        "cvtpi2pd",
        "cvtps2dq",
        "cvtps2pd",
        "cvtsd2si",
        "cvtsd2ss",
        "cvtsi2sd",
        "cvtss2sd",
        "cvttpd2dq",
        "cvttpd2pi",
        "cvttps2dq",
        "cvttsd2si",
        "divpd",
        "divsd",
        "lfence",
        "maskmovdqu",
        "maxpd",
        "maxsd",
        "mfence",
        "minpd",
        "minsd",
        "movapd",
        "movd",
        "movdq2q",
        "movdqa",
        "movdqu",
        "movhpd",
        "movlpd",
        "movmskpd",
        "movntdq",
        "movnti",
        "movntpd",
        "movq",
        "movq2dq",
        "movsd",
        "movupd",
        "mulpd",
        "mulsd",
        "orpd",
        "packssdw",
        "packsswb",
        "packuswb",
        "paddb",
        "paddd",
        "paddq",
        "paddsb",
        "paddsw",
        "paddusb",
        "paddusw",
        "paddw",
        "pand",
        "pandn",
        "pause",
        "pavgb",
        "pavgw",
        "pcmpeqb",
        "pcmpeqd",
        "pcmpeqw",
        "pcmpgtb",
        "pcmpgtd",
        "pcmpgtw",
        "pextrw",
        "pinsrw",
        "pmaddwd",
        "pmaxsw",
        "pmaxub",
        "pminsw",
        "pminub",
        "pmovmskb",
        "pmulhuw",
        "pmulhw",
        "pmullw",
        "pmuludq",
        "por",
        "psadbw",
        "pshufd",
        "pshufhw",
        "pshuflw",
        "pslld",
        "pslldq",
        "psllq",
        "psllw",
        "psrad",
        "psraw",
        "psrld",
        "psrldq",
        "psrlq",
        "psrlw",
        "psubb",
        "psubd",
        "psubq",
        "psubsb",
        "psubsw",
        "psubusb",
        "psubusw",
        "psubw",
        "punpckhbw",
        "punpckhdq",
        "punpckhqdq",
        "punpckhwd",
        "punpcklbw",
        "punpckldq",
    ],
    "sse3" => String[
        "addsubpd",
        "addsubps",
        "fisttp",
        "fisttpl",
        "fisttpll",
        "haddpd",
        "haddps",
        "hsubpd",
        "hsubps",
        "lddqu",
        "monitor",
        "movddup",
        "movshdup",
        "movsldup",
        "mwait",
    ],
    "sse4.1" => String[
        "blendpd",
        "blendps",
        "blendvpd",
        "blendvps",
        "dppd",
        "dpps",
        "extractps",
        "insertps",
        "movntdqa",
        "mpsadbw",
        "packusdw",
        "pblendvb",
        "pblendw",
        "pcmpeqq",
        "pextrb",
        "pextrd",
        "pextrq",
        "pextrw",
        "phminposuw",
        "pinsrb",
        "pinsrd",
        "pinsrq",
        "pmaxsb",
        "pmaxsd",
        "pmaxud",
        "pmaxuw",
        "pminsb",
        "pminsd",
        "pminud",
        "pminuw",
        "pmovsxbd",
        "pmovsxbq",
        "pmovsxbw",
        "pmovsxdq",
        "pmovsxwd",
        "pmovsxwq",
        "pmovzxbd",
        "pmovzxbq",
        "pmovzxbw",
        "pmovzxdq",
        "pmovzxwd",
        "pmovzxwq",
        "pmuldq",
        "pmulld",
        "ptest",
        "roundpd",
        "roundps",
        "roundsd",
        "roundss",
    ],
    "sse4.2" => String[
        "crc32",
        "pcmpestri",
        "pcmpestrm",
        "pcmpgtq",
        "pcmpistri",
        "pcmpistrm",
        "popcnt",
    ],
    "sse4a" => String[
        "extrq",
        "insertq",
        "lzcnt",
        "movntsd",
        "movntss",
        "popcnt",
    ],
    "ssse3" => String[
        "pabsb",
        "pabsw",
        "palignr",
        "phaddd",
        "phaddsw",
        "phaddw",
        "phsubd",
        "phsubsw",
        "phsubw",
        "pmaddubsw",
        "pmulhrsw",
        "pshufb",
        "psignb",
        "psignd",
        "psignw",
    ],
    "3dnow" => String[
        "femms",
        "pavgusb",
        "pf2id",
        "pf2iw",
        "pfacc",
        "pfadd",
        "pfcmpeq",
        "pfcmpge",
        "pfcmpgt",
        "pfmax",
        "pfmin",
        "pfmul",
        "pfrcp",
        "pfrcpit1",
        "pfrcpit2",
        "pfrsqit1",
        "pfrsqrt",
        "pfsub",
        "pfsubr",
        "pi2fd",
        "pi2fw",
        "pmulhrw",
        "prefetch",
        "pswapw",
    ],
    "3dnowext" => String[
        "maskmovq",
        "movntq",
        "pavgb",
        "pavgw",
        "pextrw",
        "pf2iw",
        "pfnacc",
        "pfpnacc",
        "pi2fw",
        "pinsrw",
        "pmaxsw",
        "pmaxub",
        "pminsw",
        "pminub",
        "pmovmskb",
        "pmulhuw",
        "prefetchnta",
        "prefetcht0",
        "prefetcht1",
        "prefetcht2",
        "psadbw",
        "pshufw",
        "pswapd",
        "sfence",
    ],
    "aes" => String[
        "aesdec",
        "aesdeclast",
        "aesenc",
        "aesenclast",
        "aesimc",
        "aeskeygenassist",
    ],
    "pclmul" => String[
        "pclmulqdq",
    ],
    "avx" => String[
        "vaddpd",
        "vaddps",
        "vaddsd",
        "vaddss",
        "vaddsubpd",
        "vaddsubps",
        "vaesdec",
        "vaesdeclast",
        "vaesenc",
        "vaesenclast",
        "vaesimc",
        "vaeskeygenassist",
        "vandnpd",
        "vandnps",
        "vandpd",
        "vandps",
        "vblendpd",
        "vblendps",
        "vblendvpd",
        "vblendvps",
        "vbroadcastf128",
        "vbroadcastsd",
        "vbroadcastss",
        "vcmpeq_osps",
        "vcmpeq_uqps",
        "vcmpeq_usps",
        "vcmpeqpd",
        "vcmpeqps",
        "vcmpeqsd",
        "vcmpeqss",
        "vcmpfalse_osps",
        "vcmpfalseps",
        "vcmpge_oqps",
        "vcmpgeps",
        "vcmpgt_oqps",
        "vcmpgtps",
        "vcmple_oqps",
        "vcmplepd",
        "vcmpleps",
        "vcmplesd",
        "vcmpless",
        "vcmplt_oqps",
        "vcmpltpd",
        "vcmpltps",
        "vcmpltsd",
        "vcmpltss",
        "vcmpneq_oqps",
        "vcmpneq_osps",
        "vcmpneq_usps",
        "vcmpneqpd",
        "vcmpneqps",
        "vcmpneqsd",
        "vcmpneqss",
        "vcmpnge_uqps",
        "vcmpngeps",
        "vcmpngt_uqps",
        "vcmpngtps",
        "vcmpnle_uqps",
        "vcmpnlepd",
        "vcmpnleps",
        "vcmpnlesd",
        "vcmpnless",
        "vcmpnlt_uqps",
        "vcmpnltpd",
        "vcmpnltps",
        "vcmpnltsd",
        "vcmpnltss",
        "vcmpord_sps",
        "vcmpordpd",
        "vcmpordps",
        "vcmpordsd",
        "vcmpordss",
        "vcmppd",
        "vcmpps",
        "vcmpsd",
        "vcmpss",
        "vcmptrue_usps",
        "vcmptrueps",
        "vcmpunord_sps",
        "vcmpunordpd",
        "vcmpunordps",
        "vcmpunordsd",
        "vcmpunordss",
        "vcomisd",
        "vcomiss",
        "vcvtdq2pd",
        "vcvtdq2ps",
        "vcvtpd2dq",
        "vcvtpd2dqx",
        "vcvtpd2dqy",
        "vcvtpd2ps",
        "vcvtpd2psx",
        "vcvtpd2psy",
        "vcvtps2dq",
        "vcvtps2pd",
        "vcvtsd2si",
        "vcvtsd2sil",
        "vcvtsd2ss",
        "vcvtsi2sd",
        "vcvtsi2sdl",
        "vcvtsi2ss",
        "vcvtsi2ssl",
        "vcvtss2sd",
        "vcvtss2si",
        "vcvtss2sil",
        "vcvttpd2dq",
        "vcvttpd2dqx",
        "vcvttpd2dqy",
        "vcvttps2dq",
        "vcvttsd2si",
        "vcvttss2si",
        "vdivpd",
        "vdivps",
        "vdivsd",
        "vdivss",
        "vdppd",
        "vdpps",
        "vextractf128",
        "vextractps",
        "vhaddpd",
        "vhaddps",
        "vhsubpd",
        "vhsubps",
        "vinsertf128",
        "vinsertps",
        "vlddqu",
        "vldmxcsr",
        "vmaskmovdqu",
        "vmaskmovpd",
        "vmaskmovps",
        "vmaxpd",
        "vmaxps",
        "vmaxsd",
        "vmaxss",
        "vminpd",
        "vminps",
        "vminsd",
        "vminss",
        "vmovapd",
        "vmovaps",
        "vmovd",
        "vmovddup",
        "vmovdqa",
        "vmovdqu",
        "vmovhlps",
        "vmovhpd",
        "vmovhps",
        "vmovlhps",
        "vmovlpd",
        "vmovlps",
        "vmovmskpd",
        "vmovmskps",
        "vmovntdq",
        "vmovntdqa",
        "vmovntpd",
        "vmovntps",
        "vmovq",
        "vmovsd",
        "vmovshdup",
        "vmovsldup",
        "vmovss",
        "vmovupd",
        "vmovups",
        "vmpsadbw",
        "vmulpd",
        "vmulps",
        "vmulsd",
        "vmulss",
        "vorpd",
        "vorps",
        "vpabsb",
        "vpabsd",
        "vpabsw",
        "vpackssdw",
        "vpacksswb",
        "vpackusdw",
        "vpackuswb",
        "vpaddb",
        "vpaddd",
        "vpaddq",
        "vpaddsb",
        "vpaddsw",
        "vpaddusb",
        "vpaddusw",
        "vpaddw",
        "vpalignr",
        "vpand",
        "vpandn",
        "vpavgb",
        "vpavgw",
        "vpblendvb",
        "vpblendw",
        "vpclmulhqhqdq",
        "vpclmulhqlqdq",
        "vpclmullqhqdq",
        "vpclmullqlqdq",
        "vpclmulqdq",
        "vpcmpeqb",
        "vpcmpeqd",
        "vpcmpeqq",
        "vpcmpeqw",
        "vpcmpestri",
        "vpcmpestrm",
        "vpcmpgtb",
        "vpcmpgtd",
        "vpcmpgtq",
        "vpcmpgtw",
        "vpcmpistri",
        "vpcmpistrm",
        "vperm2f128",
        "vpermilpd",
        "vpermilps",
        "vpextrb",
        "vpextrd",
        "vpextrw",
        "vphaddd",
        "vphaddsw",
        "vphaddw",
        "vphminposuw",
        "vphsubd",
        "vphsubsw",
        "vphsubw",
        "vpinsrb",
        "vpinsrd",
        "vpinsrw",
        "vpmaddubsw",
        "vpmaxsb",
        "vpmaxsd",
        "vpmaxsw",
        "vpmaxub",
        "vpmaxud",
        "vpmaxuw",
        "vpminsb",
        "vpminsd",
        "vpminsw",
        "vpminub",
        "vpminud",
        "vpminuw",
        "vpmovmskb",
        "vpmovsxbd",
        "vpmovsxbq",
        "vpmovsxbw",
        "vpmovsxdq",
        "vpmovsxwd",
        "vpmovsxwq",
        "vpmovzxbd",
        "vpmovzxbq",
        "vpmovzxbw",
        "vpmovzxdq",
        "vpmovzxwd",
        "vpmovzxwq",
        "vpmuldq",
        "vpmulhrsw",
        "vpmulhuw",
        "vpmulhw",
        "vpmulld",
        "vpmullw",
        "vpmuludq",
        "vpor",
        "vpsadbw",
        "vpshufb",
        "vpshufd",
        "vpshufhw",
        "vpshuflw",
        "vpsignb",
        "vpsignd",
        "vpsignw",
        "vpslld",
        "vpslldq",
        "vpsllq",
        "vpsllw",
        "vpsrad",
        "vpsraw",
        "vpsrld",
        "vpsrldq",
        "vpsrlq",
        "vpsrlw",
        "vpsubb",
        "vpsubd",
        "vpsubq",
        "vpsubsb",
        "vpsubsw",
        "vpsubusb",
        "vpsubusw",
        "vpsubw",
        "vptest",
        "vpunpckhbw",
        "vpunpckhdq",
        "vpunpckhqdq",
        "vpunpckhwd",
        "vpunpcklbw",
        "vpunpckldq",
        "vpunpcklqdq",
        "vpunpcklwd",
        "vpxor",
        "vrcpps",
        "vrcpss",
        "vroundpd",
        "vroundps",
        "vroundsd",
        "vroundss",
        "vrsqrtps",
        "vrsqrtss",
        "vshufpd",
        "vshufps",
        "vsqrtpd",
        "vsqrtps",
        "vsqrtsd",
        "vsqrtss",
        "vstmxcsr",
        "vsubpd",
        "vsubps",
        "vsubsd",
        "vsubss",
        "vtestpd",
        "vtestps",
        "vucomisd",
        "vucomiss",
        "vunpckhpd",
        "vunpckhps",
        "vunpcklpd",
        "vunpcklps",
        "vxorpd",
        "vxorps",
        "vzeroall",
        "vzeroupper",
    ],
    "avx2" => [
        "vblendmpd",
        "vblendmps",
        "vpblendmd",
        "vpblendmq",
        "vpblendmb",
        "vpblendmw",
        "vpcmpd",
        "vpcmpud",
        "vpcmpq",
        "vpcmpuq",
        "vpcmpb",
        "vpcmpub",
        "vpcmpw",
        "vpcmpuw",
        "vptestmq",
        "vptestmd",
        "vptestnmd",
        "vptestnmq",
        "vptestmb",
        "vptestmw",
        "vptestnmb",
        "vptestnmw",
        "vcompresspd",
        "vcompressps",
        "vpcompressd",
        "vpcompressq",
        "vexpandpd",
        "vexpandps",
        "vpexpandd",
        "vpexpandq",
        "vpermb",
        "vpermw",
        "vpermt2b",
        "vpermt2w",
        "vpermi2pd",
        "vpermi2ps",
        "vpermi2d",
        "vpermi2q",
        "vpermi2b",
        "vpermi2w",
        "vpermt2ps",
        "vpermt2pd",
        "vpermt2d",
        "vpermt2q",
        "vshuff32x4",
        "vshuff64x2",
        "vshuffi32x4",
        "vshuffi64x2",
        "vpternlogd",
        "vpternlogq",
        "vpmovqd",
        "vpmovsqd",
        "vpmovusqd",
        "vpmovqw",
        "vpmovsqw",
        "vpmovusqw",
        "vpmovqb",
        "vpmovsqb",
        "vpmovusqb",
        "vpmovdw",
        "vpmovsdw",
        "vpmovusdw",
        "vpmovdb",
        "vpmovsdb",
        "vpmovusdb",
        "vpmovwb",
        "vpmovswb",
        "vpmovuswb",
        "vcvtps2udq",
        "vcvtpd2udq",
        "vcvttps2udq",
        "vcvttpd2udq",
        "vcvtss2usi ",
        "vcvtsd2usi ",
        "vcvttss2usi ",
        "vcvttsd2usi",
        "vcvtps2qq",
        "vcvtpd2qq",
        "vcvtps2uqq",
        "vcvtpd2uqq",
        "vcvttps2qq",
        "vcvttpd2qq",
        "vcvttps2uqq",
        "vcvttpd2uqq",
        "vcvtudq2ps ",
        "vcvtudq2pd",
        "vcvtusi2ps ",
        "vcvtusi2pd",
        "vcvtusi2sd",
        "vcvtusi2ss",
        "vcvtuqq2ps",
        "vcvtuqq2pd",
        "vcvtqq2pd",
        "vcvtqq2ps",
        "vgetexppd",
        "vgetexpps",
        "vgetexpsd",
        "vgetexpss",
        "vgetmantpd",
        "vgetmantps",
        "vgetmantsd",
        "vgetmantss",
        "vfixupimmpd",
        "vfixupimmps",
        "vfixupimmsd",
        "vfixupimmss",
        "vrcp14pd",
        "vrcp14ps",
        "vrcp14sd",
        "vrcp14ss",
        "vrndscaleps",
        "vrndscalepd",
        "vrndscaless",
        "vrndscalesd",
        "vrsqrt14pd",
        "vrsqrt14ps",
        "vrsqrt14sd",
        "vrsqrt14ss",
        "vscalefps",
        "vscalefpd",
        "vscalefss",
        "vscalefsd",
        "valignd",
        "valignq",
        "vdbpsadbw",
        "vpbroadcastd",
        "vpbroadcastq",
        "vpbroadcastb",
        "vpbroadcastw",
        "vbroadcastf32x4",
        "vbroadcastf64x4",
        "vbroadcasti32x4",
        "vbroadcasti64x4",
        "vbroadcastf32x2",
        "vbroadcastf64x2",
        "vbroadcastf32x8",
        "vbroadcasti32x2",
        "vbroadcasti64x2",
        "vbroadcasti32x8",
        "vextractf32x4",
        "vextractf64x4",
        "vextracti32x4",
        "vextracti64x4",
        "vextractf64x2",
        "vextractf32x8",
        "vextracti64x2",
        "vextracti32x8",
        "vinsertf32x4",
        "vinsertf64x4",
        "vinserti32x4",
        "vinserti64x4",
        "vinsertf64x2",
        "vinsertf32x8",
        "vinserti64x2",
        "vinserti32x8",
        "vpabsq",
        "vpmaxsq",
        "vpmaxuq",
        "vpminsq",
        "vpminuq",
        "vpmultishiftqb",
        "vprold",
        "vprolvd",
        "vprolq",
        "vprolvq",
        "vprord",
        "vprorvd",
        "vprorq",
        "vprorvq",
        "vpscatterdd",
        "vpscatterdq",
        "vpscatterqd",
        "vpscatterqq",
        "vscatterdps",
        "vscatterdpd",
        "vscatterqps",
        "vscatterqpd",
        "vmovdqa32",
        "vmovdqa64",
        "vmovdqu8",
        "vmovdqu16",
        "vmovdqu32",
        "vmovdqu64",
        "vpxord",
        "vpxorq",
        "vpconflictd",
        "vpconflictq",
        "vplzcntd",
        "vplzcntq",
        "vpbroadcastmb2q",
        "pbroadcastmw2d",
        "vexp2pd",
        "vexp2ps",
        "vrcp28pd",
        "vrcp28ps",
        "vrcp28sd",
        "vrcp28ss",
        "vrsqrt28pd",
        "vrsqrt28ps",
        "vrsqrt28sd",
        "vrsqrt28ss",
        "vgatherpf0dps",
        "vgatherpf0qps",
        "vgatherpf0dpd",
        "vgatherpf0qpd",
        "vgatherpf1dps",
        "vgatherpf1qps",
        "vgatherpf1dpd",
        "vgatherpf1qpd",
        "vscatterpf0dps",
        "vscatterpf0qps",
        "vscatterpf0dpd",
        "vscatterpf0qpd",
        "vscatterpf1dps",
        "vscatterpf1qps",
        "vscatterpf1dpd",
        "vscatterpf1qpd",
        "vfpclassps",
        "vfpclasspd",
        "vfpclassss",
        "vfpclasssd",
        "vrangeps",
        "vrangepd",
        "vrangess",
        "vrangesd",
        "vreduceps",
        "vreducepd",
        "vreducess",
        "vreducesd",
        "vpmovm2d",
        "vpmovm2q",
        "vpmovm2b",
        "vpmovm2w",
        "vpmovd2m",
        "vpmovq2m",
        "vpmovb2m",
        "vpmovw2m",
        "vpmullq",
        "vpmadd52luq",
        "vpmadd52huq",
        "v4fmaddps",
        "v4fmaddss",
        "v4fnmaddps",
        "v4fnmaddss",
        "vp4dpwssd",
        "vp4dpwssds",
        "vpopcntd",
        "vpopcntq",
    ],

)

# Turn instructions "inside out", so e.g. we have "vzeroall" => "avx"
mnemonics_by_category = Dict(
    inst => cat for (cat, insts) in instruction_categories for inst in insts
)


"""
    instruction_mnemonics(path::AbstractString, platform::Platform)

Dump a binary object with `objdump`, returning a list of instruction mnemonics
for further analysis with `analyze_instruction_set()`.

Note that this function only really makes sense for x86/x64 binaries.  Don't
run this on armv7l, aarch64, ppc64le etc... binaries and expect it to work.

This function returns the list of mnemonics as well as the counts of each,
binned by the mapping defined within `instruction_categories`.
"""
function instruction_mnemonics(path::AbstractString, platform::Platform)
    # The outputs we are calculating
    counts = Dict(k => 0 for k in keys(instruction_categories))
    mnemonics = String[]

    ur = preferred_runner()(
        abspath(dirname(path));
        cwd="/workspace/",
        platform=platform,
        verbose=false,
    )
    output = IOBuffer()

    # Run objdump to disassemble the input binary
    objdump_cmd = "\$OBJDUMP -d $(basename(path))"
    run_interactive(ur, `/bin/bash -c "\$OBJDUMP -d $(basename(path))"`; stdout=output)
    seekstart(output)

    for line in eachline(output)
        # First, ensure that this line of output is 3 fields long at least
        fields = split(line, '\t')
        if length(fields) < 3
            continue
        end

        # Grab the mnemonic for this line as the first word of the 3rd field
        m = split(fields[3])[1]
        push!(mnemonics, m)

        # For each mnemonic, find it in mnemonics_by_category, if we can, and
        # increment the appropriate `counts` member:
        if haskey(mnemonics_by_category, m)
            counts[mnemonics_by_category[m]] += 1
        else
            counts["unknown"] += 1
        end
    end

    # Return both the list of mnemonics as well as the binned counts
    return mnemonics, counts
end

"""
    minimum_instruction_set(counts::Dict, is_64bit::Bool)

This function returns the minimum instruction set required, depending on
whether the object file being pointed to is a 32-bit or 64-bit one:

* For 32-bit object files, this returns one of [:pentium4, :prescott]

* For 64-bit object files, this returns one of [:core2, :sandybridge, :haswell]
"""
function minimum_instruction_set(counts::Dict, is_64bit::Bool)
    if is_64bit
        if counts["avx2"] > 0
            return :haswell
        end
        if counts["avx"] > 0
            return :sandybridge
        end
        return :core2
    else
        if counts["sse3"] > 0
            return :prescott
        end
        return :pentium4
    end
end


"""
    analyze_instruction_set(oh::ObjectHandle, platform::Platform; verbose::Bool = false)

Analyze the instructions within the binary located at the given path for which
minimum instruction set it requires, taking note of groups of instruction sets
used such as `avx`, `sse4.2`, `i486`, etc....

Some binary files (such as libopenblas) contain multiple versions of functions,
internally determining which version to call by using the `cpuid` instruction
to determine processor support.  In an effort to detect this, we make note of
any usage of the `cpuid` instruction, disabling our minimum instruction set
calculations if such an instruction is found, and notifying the user of this
if `verbose` is set to `true`.

Note that this function only really makes sense for x86/x64 binaries.  Don't
run this on armv7l, aarch64, ppc64le etc... binaries and expect it to work.
"""
function analyze_instruction_set(oh::ObjectHandle, platform::Platform; verbose::Bool = false, io::IO = stdout)
    # Get list of mnemonics
    mnemonics, counts = instruction_mnemonics(path(oh), platform)

    # Analyze for minimum instruction set
    min_isa = minimum_instruction_set(counts, is64bit(oh))

    # If the binary uses `cpuid`, we can't know what it's doing, so just
    # return the most conservative ISA and warn the user if `verbose` is set.
    if counts["cpuid"] > 0
        new_min_isa = is64bit(oh) ? :core2 : :pentium4
        if verbose && new_min_isa != min_isa
            msg = replace("""
            $(basename(path(oh))) contains a `cpuid` instruction; refusing to
            analyze for minimum instruction set, as it may dynamically select
            the proper instruction set internally.  Would have chosen
            $(min_isa), instead choosing $(new_min_isa).
            """, '\n' => ' ')
            warn(io, strip(msg))
        end
        return new_min_isa
    end

    # Otherwise, return `min_isa` and let 'em know!
    return min_isa
end

