KURTOSIS_IP_ADDRESS_PLACEHOLDER = "KURTOSIS_IP_ADDR_PLACEHOLDER"

GLOBAL_LOG_LEVEL = struct(
    info = "info",
    error = "error",
    warn = "warn",
    debug = "debug",
    trace = "trace",
)

JWT_MOUNT_PATH_ON_CONTAINER = "/jwt/jwt-secret.hex"
JWT_FILEPATH = "/kurtosis/src/nodes/jwt-secret.hex"
KZG_TRUSTED_SETUP_FILEPATH = "/kurtosis/src/nodes/kzg-trusted-setup.json"
BLUTGANG_CONFIG_TEMPLATE_FILEPATH = "/kurtosis/src/services/blutgang/config.toml.tmpl"

def new_prefunded_account(address, private_key):
    return struct(address = address, private_key = private_key)

PRE_FUNDED_ACCOUNTS = [
    new_prefunded_account(
        "0x20f33ce90a13a4b5e7697e3544c3083b8f8a51d4",
        "fffdbb37105441e14b0ee6330d855d8504ff39e705c3afa8f859ac9865f99306",
    ),
    new_prefunded_account(
        "0x56898d1aFb10cad584961eb96AcD476C6826e41E",
        "9b9bc88a144fff869ae2f4ea8e252f2494d9b52ea1008d0b3537dad27ab489d5",
    ),

    # Starting here we use this mnemonic 'brass gallery tennis vintage crack virus outside bike fossil shock sword panda ritual about cover clap fruit festival parrot capable high vacant orchard hurt'
    new_prefunded_account(
        "0x1e2e53c2451d0f9ED4B7952991BE0c95165D5c01",
        "0x23b19fd0ba67f921bc1f5a133bfe452060d129f025fcf1be75c6964551b1208a",
    ),
    new_prefunded_account(
        "0x3bd0E8f1B1E8Ec99a4E1762F4058F9884C93af31",
        "0x0e67856b2a42ca52862a60d11e3ac57871988aefe7a28ecd20bd8c2dec55da25",
    ),
    new_prefunded_account(
        "0xD073a84e2ccDF91a9025179330438485E886D206",
        "0xa901724fadf8e33b97e907d903dda50553969f6c8be510199878989c459b629a",
    ),
    new_prefunded_account(
        "0x8a88215ae882dfA519730c40109556c1C235729f",
        "0x110ecfb76a8a19b4fc32d7842548e00d7d6c1ba48bbc5d760eb97c9cd6fdbdc6",
    ),
    new_prefunded_account(
        "0x1a0A57e5e6a66aD732295ddAF0aed286a4e64310",
        "0xc6b45ae662b588d7419202030581e1c104414dcd79b2c7d43b29908190b4b983",
    ),
    new_prefunded_account(
        "0x185F4Eebd01614aE3d12a5E49b184B054C46d37B",
        "0x668eedaaaa05e87a9e62364f4ee75aba0aa78e13fb0142882ecb5beb2b58eb09",
    ),
    new_prefunded_account(
        "0xdb96E9cDD1e457b602f97d33e51736D7a5216496",
        "0x11c442db1d30e3f926f7e8c4a4208574d682669c6d720cb7d4eec910c0cfc863",
    ),
    new_prefunded_account(
        "0x44a5FBfa7d6f3Fd92cca01f6764509f8Fc33dfa5",
        "0x2ad0867fb0a18a3c0d8ef4dfce28e5356575f7a4a583ea1be7e50b0294d44614",
    ),
    new_prefunded_account(
        "0x3649839562C8dA64E6215EB0f5371629Ead9729D",
        "0x79ffac4f8ea5fcab09114a00e83e36b4c509ed46cdf20e5f9ba080a43fa1ebb6",
    ),
    new_prefunded_account(
        "0x51e15e71c865FE702C9347610667f83658A20e00",
        "0xe8a6d4a8d7e48ad04111ef3c0727c77548a4e3f63ffae670a9a795c3c4273889",
    ),
    new_prefunded_account(
        "0xBC9BC89b295a14F3976234Cc37C73e3D286f3a49",
        "0x306e4df414d24524c01716fc26162506e760503a6ec8646fbdc7711a603608aa",
    ),
    new_prefunded_account(
        "0x12De044207a90709Ef2602D3D9D945d64dAe6147",
        "0x51dd5ac7fa687e86670623dbe48d19733fc89ed4ffec78effa6db68956afd3e5",
    ),
    new_prefunded_account(
        "0x4Afe0DFDAcc91F0fA2AEe39F9eAd66b64d03EbD6",
        "0xde57bd35f2dec5cd25c524f0bf0d62dcca84709fb1a9371a7efcd30a9af945cb",
    ),
    new_prefunded_account(
        "0xBC3c03b4185A6F10618CC4E7B9f4AdD59AB5FbbA",
        "0xd9a59c0514630682109fa233df2e86399835f72c1b30220af7e8fea11a971592",
    ),
    new_prefunded_account(
        "0xDc6De65f6070b409125217a12Cf576A208Cc1998",
        "0x00e89a500a096d53e2b2d1dfebc9f024ddc9ba5b2d3aeced79c87917cd3bddfc",
    ),
    new_prefunded_account(
        "0xF60fD8632Fc77E19b3A0637d115d0fdd06F36968",
        "0x634cffbe3f71b9dc4227563a4cb80204940dad303af48b0e66c9ef0ae0a6dd7c",
    ),
    new_prefunded_account(
        "0xbcC90AD39D377cA0b7b4F36eC463103E2728C33F",
        "0x00da370da5af1511feea6fbe327ce13d6f1355957781698fd5f31c4b7e68f568",
    ),
    new_prefunded_account(
        "0x6F69542fC88fF84C480FFf510aB7108120447247",
        "0x3536343125036f602508e7c5e05b102133360dcfbe98fb36ef76cebcfd3626d4",
    ),
    new_prefunded_account(
        "0x2f6eB3D9a41157322dE01A6E707F6F118Cb00A7b",
        "0x5612e01bb58597611457dfca072325b84d612be3b04378ba4be76a9ea681f5ec",
    ),
    new_prefunded_account(
        "0x187bE38A1f448b0F42423151A683dCAea949008B",
        "0x92b11cad0aa9a1c894157f4ff51bb905a13d0c47445e3033a0c46af802f2cd96",
    ),
    new_prefunded_account(
        "0xA1d283f1a11A36D20FF38F29e12CA8F7Cf8709c1",
        "0xb60dc9ebb4a6a301f28d69df14dfa48a699c941ae88bef1226d22034e7be4f90",
    ),
    new_prefunded_account(
        "0x868a33C94F91398B6245e1f0E4CF128B2F28714B",
        "0xa53464fd5ce1ad3f74bd2fef45fd81a4f8430b73900354b979a8cec409a6ddf0",
    ),
    new_prefunded_account(
        "0x67c942Ef50Fc690eA779067a6A0d444a8234baB5",
        "0x0310a72661205364e7f341b3a338d3a3bf6f2876403a3bd618be4f2f01af8b91",
    ),
    new_prefunded_account(
        "0xDE8E0E641E2Fb52c22460e6a1533c6BD13A00B37",
        "0x25e28dea3bc8c317608c6c8f6c394bce47fd5ff29ef8c101ec6f2bb678fc5093",
    ),
    new_prefunded_account(
        "0x9beFa0FB7a1A9E6cC7596204DbB8962E87091D64",
        "0x90e03f14c68e4c14b58b68668a68b8512bb21994cf05cb2c1af4d3e454a01999",
    ),
    new_prefunded_account(
        "0x62cB9bF32EA104f6D5eBf6879e876439f9492E4B",
        "0xa44b22fb3a02ec16a5c31b37878600647e5d43f51e2bb7e76fd0c6e2653db0a0",
    ),
    new_prefunded_account(
        "0xdb9cB94B166DfdC9F337EA63b32B448d993d7008",
        "0x71e76153038a529f306872ce3f01d246aa80982906d8c6092543fa8df76e0d73",
    ),
    new_prefunded_account(
        "0x7c4d7dB81c544B768E1f4782011077202B74B5C0",
        "0xe39d434543ebcc9db6467b4fc121220f06dad303df4f3cc0a51aff235273932f",
    ),
    new_prefunded_account(
        "0xaEf63D7F7e2637c99FeA1B63366b244B4da12D70",
        "0xb76ea4844f198d945449c28f795fa199f70f1bd37d0a1b4f489bf7f79639e6d0",
    ),
    new_prefunded_account(
        "0x3DFb4173ec41EB976260fd689E5AB9772C66beaf",
        "0x79b28c32e7b04ca737c6b9e9b2629ac8292285afa10ae73ee42706bea07a6940",
    ),
    new_prefunded_account(
        "0x5145b1B855bca67A119CB02A42aF4Bdbc66B725C",
        "0xa6e875f1d2991796746acada577196a56095ee2f684a00bb74b463336f3c0f0e",
    ),
    new_prefunded_account(
        "0xf4b2eb959A4C4b0E148340676999FC0446D446D4",
        "0x47b6a89108b41866932fa7448ad0feedec22b3baa9ab7f69c7564edf252420d4",
    ),
    new_prefunded_account(
        "0xb86d37333072eFb48cEaa46C67271A27CA5Bda82",
        "0x4ae54fa2370d6c515c30d9b0c04724dee47e684d1df754c775f5bf3d6ea03269",
    ),
    new_prefunded_account(
        "0x6CBcF4198fDA91D00fD469340E6DF6df086159e3",
        "0x9defa91490f3d1b6c67a682f06066bd72c7027dfd396e49aa9c10ab9c54b6196",
    ),
    new_prefunded_account(
        "0xE7F444b5f772281384117674002d540131e533Ca",
        "0xb0f3c0cea50abb97f50fa0777f7937ccfb4d558807a90c7eb4b0f674e7e74768",
    ),
    new_prefunded_account(
        "0x719Be866A77CeEc1BaC4FD37910c0975eFd52f55",
        "0x1c4e0bceb9d758e1aca207f430ef2963d483aeb6d5b073da049d8823ffe98a94",
    ),
    new_prefunded_account(
        "0x0e10cDAd84D788843aF48673C5b260A02ef78742",
        "0x20127f5feedc14aa3e3a6ac38d464e5c550093cc6b6d338f4a34bb9538e36e4c",
    ),
    new_prefunded_account(
        "0xcB6632daA65e6c921c2963C37320f63f54fC8fE3",
        "0x18500f6a8cf63787326c992e34d6d9ffad599ad14c62e8e9b383f889de935d7f",
    ),
    new_prefunded_account(
        "0xDe5C7198e2416baB7e7a1EA758858Cd7301740bF",
        "0x196df6fdda754bafd85228004b3c2173ccf6d42bdcd332ff78366185758aa44e",
    ),
    new_prefunded_account(
        "0x25fc16D8E2314B305dF05C032E617638284801D6",
        "0x0bb8e01ef0afe7715d1e0ee9ff33981862e680ae3299c32dc455ad256996ebbb",
    ),
    new_prefunded_account(
        "0xD2a3b89AE8D2c3bD39E2F24612ecFCD8600360C9",
        "0x7d3d3ace1f1164a8307c5187f43fe620d180be936391e36c435b0c594866d57f",
    ),
    new_prefunded_account(
        "0x2F4fD8a82A1400E654eeEC59b0e588445ffE0F96",
        "0x7916a06ca827d932627c7a82e9a68b7d79b1d64c139cfab14b97f9f0299cc576",
    ),
    new_prefunded_account(
        "0x10FdFa4EFc83d6CC42F5ef14c13da8b98E458214",
        "0x7f73e04379f0816b4eb5a579d575f34297f4a73713ffcfaf60a5b6116d6c1637",
    ),
    new_prefunded_account(
        "0x49cE37B2019bb2d0B8b6a094ef87a6Dd625454A0",
        "0x6174d6f44b02fac531b5cb0001b5c6a8ef7a94c349b70f2f1658f9e64120a9c5",
    ),
    new_prefunded_account(
        "0x800830F031ab1dd5895a5ec5B561427AD18f9ea8",
        "0xbb9de8caf4cd75f2775e2303f2f7d14127da8a32c029b3b6be195d0cb175cb34",
    ),
    new_prefunded_account(
        "0x3124d9885b11B52c56A2aee610AfCf5740d484F0",
        "0x67730ed1e0992a4541f1e24fe62e7356ee1affa9fa1e063025f803d594b796d0",
    ),
    new_prefunded_account(
        "0xA6177defF3b768b1D678EdF7583b8cf210C777c0",
        "0x5d3b93032a2a8422bc8188dcd86732e104a7e145ce1c417a425057ad84700a6d",
    ),
    new_prefunded_account(
        "0xF99139D2FCc5E25F57B0B91fd382a21B3AFF9cbA",
        "0xaedb174cee8faf87cfc89d1b0b8d3f71ce4fa093c1d3f6f95d66ca6d56c07a18",
    ),
    new_prefunded_account(
        "0xC4DD08191B4d5173e3698491A11e05b63F9Ee097",
        "0x794b0f636acc2d481d8a007c5c814b5ab0285b0f2dc4f09249cb140d232440c9",
    ),
    new_prefunded_account(
        "0xB8865B4B8C56861534CC07ebBD2EA569a9a16323",
        "0x5242412b3f8cfc334085ff367f7b0edcd9147128db5372f5af1c4a1653f65526",
    ),
    new_prefunded_account(
        "0x2B9935698dc5c19Ab7414AE22f27Da5F4478008a",
        "0x6c1f3aeff292aa72c4b3b29126acc1a3d221fb15cdd21a91afdea30197a3f693",
    ),
    new_prefunded_account(
        "0xAC3c80F41C3049A89Aba8072FFbFc38a90fb6D8c",
        "0x2a54bc87952ecdb225fecf5e17cda5e34a7af57a04f52f6cb3ea0fd73034b504",
    ),
    new_prefunded_account(
        "0xD6D4Fb22B91FAa54700852a05698B37d45514166",
        "0x5f5aafe935bdb54b7963f0a1198b5aa40fb076bb042d8cbb473202d223d4f661",
    ),
    new_prefunded_account(
        "0xAf325Ccc92ae883DEF1634D499d8B093192D7a0c",
        "0x12042bc310f17a3e138aed39d36db6a3fd79fc34af82d4579cb453bb106e20fd",
    ),
    new_prefunded_account(
        "0x7469CeEf99FB67e4990c5F1c085a1B39b2902331",
        "0x4763d00f07519325799eb96f1afc2b6495c962839f42c8947fcbb0fcb7714cb5",
    ),
    new_prefunded_account(
        "0x14DA5251a1EB236238969575ccE943e2Fb0f4AA1",
        "0x360d7a4c43661dc20b6b45aecc74731157820febd977d0e3f361c241505c2646",
    ),
    new_prefunded_account(
        "0xF9f58a87C3f0B3A4a0592938c80C41a7c659f855",
        "0x05ad2e2038fbbe5175b32ce433058ced25dcda16c1a9096a2babc67c6aded430",
    ),
    new_prefunded_account(
        "0x1CF7e940A657eE706718CF180eb21864DE9672C3",
        "0x77a7ea3cb368bfa6fafbb030fad7a8d1a5bb7522aaa6812f93cd48078cc9d777",
    ),
    new_prefunded_account(
        "0x440C37b22e8D7469128Ea7De6ac2f31419B4A8b1",
        "0x4eeb502b10d35d16f453e2c0c2047ec28040ca2535d1c3ef07e8a0df672a38d4",
    ),
    new_prefunded_account(
        "0x4bD04ABA9fc709835b1EE4789195d10E9e8E53F5",
        "0x7f3bc64adc04bb815c5308879e00adc474a6e5398753b2884d457dae9702edd7",
    ),
    new_prefunded_account(
        "0x4dC3aC871b22F8a98197B0aae976a8dE08e5Bebe",
        "0x4bb60046eed4f37440632278668a0f2137cd6853d716186b0feff56d3fac53d0",
    ),
    new_prefunded_account(
        "0x1f1D0FCa7e19b799c315d4fDf31bA50e6A2AB153",
        "0xaf68c285514858fdeb576b9a0b8429cad69d3a5b5e443b9da98a96a10b6e322b",
    ),
    new_prefunded_account(
        "0x28879749Dda99387bdB43295B28bdF251d999F3b",
        "0x411fad907c3951644ff9c1789488c70de8794913d53d946a5cb9af2f019f2396",
    ),
    new_prefunded_account(
        "0xC4eD09A472B82516daa3A4d8D1E38AE94CF4855C",
        "0x349d0efb83a78c04878e1b84dc50ba61f51d82dbcd4a93d6aa8469ed0bf36a76",
    ),
    new_prefunded_account(
        "0xf22FbA9cBeB75ED353931418E9eca71EF1Ab9921",
        "0x4b850afd62171d5152fd3ae606e9a54504331f5e05d2afd4425c8bb0593bc663",
    ),
    new_prefunded_account(
        "0xC59D8935c0570E75BA0E55E3C661f535C86e368B",
        "0x6df174e811caed865c56b85249da60ed6012d4a85defda84342080219408e615",
    ),
    new_prefunded_account(
        "0xf97a36c417D33D1fC60a9163A8715e1aecb29102",
        "0x4d2686dca939e451ada1c2c60b43ec51751a043013613e99a7f2657dc7e71857",
    ),
    new_prefunded_account(
        "0x4245537d9e3fb36fBBf054247FfFB28b0d931503",
        "0x771675f7f662ce044421ef85e9f4d01b67cbf4dc49bcd8c66ba051b58cfa36b1",
    ),
    new_prefunded_account(
        "0xFeb1eafa0154D291e28e393FAF10Bc89e5cCbB22",
        "0x2bad44bacec98635554cceec959a4913ed70bbc22c41652432ed8449c3ba8659",
    ),
    new_prefunded_account(
        "0xf11D16e2EE6BefED82Fbca0b005906E09303aB95",
        "0xc090fc69382106e7b4563b5132d1791950144611ace0a13c74660512f04d262f",
    ),
    new_prefunded_account(
        "0x9C75eD1A37ae420b4FC0a1F4c26B673227Fd3AFa",
        "0xf128a6a5e4465a627b97b0e5456a098550fcbac6688a9d7ec8f327934ee9f493",
    ),
    new_prefunded_account(
        "0x6a354C708fd248FD778F6adF75E41AA554700F68",
        "0xc3cc22368afd808e703e3679043a8803f9185e5be4c27a99805b3156970bcc62",
    ),
    new_prefunded_account(
        "0xea94749deFcc40dC5992687974b1C84B1bB9D6df",
        "0x1ea128368d1cd5ff6f548cf22e1e9f8a60acd5937dd5a77280cebe75705ba362",
    ),
    new_prefunded_account(
        "0x7689BE67b205EB5d32811d95D60587Eae4F3036F",
        "0x177933fe33ff1be7e031cdcbc90bd8c686aa8e809dbe9eaae4da2e7e659281ca",
    ),
    new_prefunded_account(
        "0xdBfb742BD2e0e6E353cb61E75B9e11257aC8fB1A",
        "0x4afe37059cee4b8dff36e6ede45fa47e96971a77a45e6e3e4a64ae204ab01ff4",
    ),
    new_prefunded_account(
        "0x2E5f031578e8FF82199aaF16f42c44D43Fe61819",
        "0x18bceb845b15b430b2fdb4dfa19bcf6a2ca9fc99f215df9d44c715ee7efe8067",
    ),
    new_prefunded_account(
        "0x611a42A2EF62c2461D123e3F0B64b93938bc4781",
        "0x206ff78c78e9301bc8b11fc658a9bbc722152b6739038938347e02ec4d0e9bc6",
    ),
    new_prefunded_account(
        "0x1a0c826048DF0E4661E3c53bBd447d497E3f701F",
        "0x40e62b0f968d1185354a33e2d63087f86e8925e1158419e467a327d4d115f732",
    ),
    new_prefunded_account(
        "0x7f0E54bc3C1a72405646F5dFbBE0D4565c649fe2",
        "0x62fd8b90b047849fed591bf2ff867a8437bd20c759376ceb587e7fb9b5eefef8",
    ),
    new_prefunded_account(
        "0x54e1F990Dc0B7367F1E8eD96dA63BC4bca0E8061",
        "0xaa4273b5eaf92f77bd98944d362a51001101b35c708b7a144074b8e6c05c8831",
    ),
    new_prefunded_account(
        "0xbE651bc261b9Da5499a24Bf4214fD494c6e1F5Ac",
        "0x95695009fe4132a590cfce1cc0a9980a51e730ea2ec8449c3f94531d55063d70",
    ),
    new_prefunded_account(
        "0xD3c5dAC705289cD005C402C79C8445a47502d8be",
        "0xcf89fbd9ef2d93c5839fded6a80be8af79c95cc9c62255c660e47fe03531789d",
    ),
    new_prefunded_account(
        "0xE5981AA0807eb05611cDb666e32e53b2001bd61d",
        "0xa511d7ddbd3de692c29330d9dfa9dbb6d910607848fb40f14f19107d07982d9a",
    ),
    new_prefunded_account(
        "0x0fb648Cb08e21602AF61AF53fE104E29d46433F7",
        "0x8b9e4e5748ac1768c78292daa4c4791af24fe0d67e8a98aab5ef02501d3dfa29",
    ),
    new_prefunded_account(
        "0x0474f52d25529c4db5f4E72F43303dA71B3541C6",
        "0x3c9ccc6a117204e9dca913ffc04b2ce235cafba8feb6dac15c47594c315d525d",
    ),
    new_prefunded_account(
        "0xe3024d098953661638d59E06f7FcD0B61c424854",
        "0xbaaf13a119fb0dfe196452d25b9452dd9ac6e2d9b18dc25ab141edab71433252",
    ),
    new_prefunded_account(
        "0x8b1e58f651CacaAa40291d2a6E0a6404d7Ed99e6",
        "0x5f3b3f4b7df21eb2032b9c5340ead919fe4b33788428c1634812e77b1f736da2",
    ),
    new_prefunded_account(
        "0x8724C57fb8f38A1FccA7177543dd1D8FcD49E5aa",
        "0xc24373d037a7e85f0b24fd0664fe9466955c04f97dad338bde0b6711e83db961",
    ),
    new_prefunded_account(
        "0xd0F043dED28773953562f824334C4cbb84210AE7",
        "0x5e66a59b22d0284554824c42043bca69d96b41693c8504228332743191fb5c41",
    ),
    new_prefunded_account(
        "0xE3d2b9191EaBD3636A5dd057D522335cfae8c7CF",
        "0x33663a07dcae30eabe33966af3c7346d7e6fda84d4f5f2d5c6ecb7182875255e",
    ),
    new_prefunded_account(
        "0x3f51B3BB6A18141282Ba002F7709c7E2f337F961",
        "0x1a9c0e36f536927b1bb371479e3e66da1d76c3cef38dc8df6abcd7f885eb2b37",
    ),
    new_prefunded_account(
        "0xf6B6A52aA9BD788837c6682f47ACE009BD84b6fc",
        "0x9d4f7b83d269e83cab82a829a4af8cdfc75f222266b59da05659fe81f0a9160a",
    ),
    new_prefunded_account(
        "0x795B761Db5969B7ba53472d5D37c230C859a472F",
        "0xb4f6c92d12dcaa5dde866306ba3bf13ee6a2f93579b9b5659df84e55043473cc",
    ),
    new_prefunded_account(
        "0x7d7f187C2A05cDDCF700dCF2E02c96E7eF03f9B0",
        "0xf5ef0b476332f7384b0d22dfe04079b71b75396ea31df7af83372dbddc34a758",
    ),
    new_prefunded_account(
        "0x2d88ECD4d8F4b0A954886eE8C0802aE14684cd07",
        "0x92765a2ecd92b6166663763194d31e89d6609b24222b5634cabf4b4813ac973d",
    ),
    new_prefunded_account(
        "0x92B3feac5b7816Dcef96a303c1D5112271A70D2c",
        "0x2846ec46730e70b54a766caac56d13832d19bdccf57254931cf195a54595d36c",
    ),
    new_prefunded_account(
        "0x5DD7bc3BEE395831ce499315ecAFE81DE0556F99",
        "0x9408db8dbf6eb04ce9d35b332dab7f82d9092c18f8bc591fa97fb3ed300f3254",
    ),
    new_prefunded_account(
        "0x5227aaebCA3E5e893547A667666E2e4e12Ca20e0",
        "0xb4eadccdc48d78d5c2bf1f608b68e971b27b49c984ada2c1237c092f823f1511",
    ),
    new_prefunded_account(
        "0x47575DAE85403cD408d4639068D1187C427B9897",
        "0x3f380d57c59b08cc54e5daa9edc2bbeb9946ed55800513ecac6c36e3216df1df",
    ),
    new_prefunded_account(
        "0xE69ac59e1DF47291AaB8DEc540C796f81De7c892",
        "0xe4f5eff00c76ec509ac9fc9f0dd4c90df9d275d72200da735ff318d7da102efc",
    ),
    new_prefunded_account(
        "0xb87fb371Bd3C2093b608cd0E7a8dDD60Bb05C995",
        "0x778b9f67675f289c9aeea78c80799ec5a625d655932733463e3a890f8f9d7e69",
    ),
]
