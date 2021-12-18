# Demo project of Swift language crash using Release build

## Repro steps

1. Open `GetOpaqueTypeMetadataSwiftUICrash.xcodeproj`
2. Product -> Profile
3. Run the app on 

## Crash Stack

```
Exception Type:  EXC_BAD_ACCESS (SIGSEGV)
Exception Subtype: KERN_INVALID_ADDRESS at 0x0000000000000000
Exception Codes: 0x0000000000000001, 0x0000000000000000
VM Region Info: 0 is not in any region.  Bytes before following region: 4300931072
      REGION TYPE                    START - END         [ VSIZE] PRT/MAX SHRMOD  REGION DETAIL
      UNUSED SPACE AT START
--->  
      __TEXT                      1005b0000-1005b8000    [   32K] r-x/r-x SM=COW  ...aSwiftUICrash
Exception Note:  EXC_CORPSE_NOTIFY
Termination Reason: SIGNAL 11 Segmentation fault: 11
Terminating Process: exc handler [36140]

Triggered by Thread:  0

Application Specific Information:
CoreSimulator 783.5 - Device: iPhone 8 (08E7BC60-2194-428E-98BD-32B32A359CC7) - Runtime: iOS 14.0 (18A394) - DeviceType: iPhone 8
dyld4 config: DYLD_ROOT_PATH=/Library/Developer/CoreSimulator/Profiles/Runtimes/iOS 14.0.simruntime/Contents/Resources/RuntimeRoot DYLD_LIBRARY_PATH=/Users/[user]/Library/Developer/Xcode/DerivedData/GetOpaqueTypeMetadataSwiftUICrash-fmdpgccnwivcgjevwqtrvhoxflet/Build/Products/Release-iphonesimulator DYLD_FRAMEWORK_PATH=/Users/[user]/Library/Developer/Xcode/DerivedData/GetOpaqueTypeMetadataSwiftUICrash-fmdpgccnwivcgjevwqtrvhoxflet/Build/Products/Release-iphonesimulator


Thread 0 Crashed::  Dispatch queue: com.apple.main-thread
0   libswiftCore.dylib            	       0x18e26b728 swift::ResolveAsSymbolicReference::operator()(swift::Demangle::SymbolicReferenceKind, swift::Demangle::Directness, int, void const*) + 64
1   libswiftCore.dylib            	       0x18e282fe4 swift::Demangle::Demangler::demangleSymbolicReference(unsigned char) + 200
2   libswiftCore.dylib            	       0x18e282fe4 swift::Demangle::Demangler::demangleSymbolicReference(unsigned char) + 200
3   libswiftCore.dylib            	       0x18e2803d8 swift::Demangle::Demangler::demangleType(llvm::StringRef, std::__1::function<swift::Demangle::Node* (swift::Demangle::SymbolicReferenceKind, swift::Demangle::Directness, int, void const*)>) + 184
4   libswiftCore.dylib            	       0x18e270790 swift_getTypeByMangledNameImpl(swift::MetadataRequest, llvm::StringRef, void const* const*, std::__1::function<swift::TargetMetadata<swift::InProcess> const* (unsigned int, unsigned int)>, std::__1::function<swift::TargetWitnessTable<swift::InProcess> const* (swift::TargetMetadata<swift::InProcess> const*, unsigned int)>) + 460
5   libswiftCore.dylib            	       0x18e26e2c0 swift::swift_getTypeByMangledName(swift::MetadataRequest, llvm::StringRef, void const* const*, std::__1::function<swift::TargetMetadata<swift::InProcess> const* (unsigned int, unsigned int)>, std::__1::function<swift::TargetWitnessTable<swift::InProcess> const* (swift::TargetMetadata<swift::InProcess> const*, unsigned int)>) + 540
6   libswiftCore.dylib            	       0x18e26e4b8 swift_getTypeByMangledNameInContext + 128
7   GetOpaqueTypeMetadataSwiftUICrash	       0x1005b5b04 __swift_instantiateConcreteTypeFromMangledName + 52
8   GetOpaqueTypeMetadataSwiftUICrash	       0x1005b4ff8 closure #1 in ContentView.body.getter + 240 (ContentView.swift:23)
9   GetOpaqueTypeMetadataSwiftUICrash	       0x1005b5d9c partial apply for closure #1 in ContentView.body.getter + 16
10  SwiftUI                       	       0x1b28edd48 NavigationView.init(content:) + 68
11  GetOpaqueTypeMetadataSwiftUICrash	       0x1005b57d0 ContentView.body.getter + 52 (ContentView.swift:17) [inlined]
12  GetOpaqueTypeMetadataSwiftUICrash	       0x1005b57d0 protocol witness for View.body.getter in conformance ContentView + 92 (<compiler-generated>:16)
13  SwiftUI                       	       0x1b28bbbe4 ViewBodyAccessor.body(of:) + 32
14  SwiftUI                       	       0x1b2b7a410 closure #1 in DynamicBody.updateValue() + 156
15  SwiftUI                       	       0x1b2b7a2a0 DynamicBody.updateValue() + 1600
16  SwiftUI                       	       0x1b28da3a0 partial apply for implicit closure #2 in implicit closure #1 in closure #1 in closure #1 in Attribute.init<A>(_:) + 28
17  AttributeGraph                	       0x1a8e63e30 AG::Graph::UpdateStack::update() + 484
18  AttributeGraph                	       0x1a8e64238 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 320
19  AttributeGraph                	       0x1a8e69164 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 380
20  AttributeGraph                	       0x1a8e79c88 AGGraphGetValue + 220
21  SwiftUI                       	       0x1b2a81010 MakeBody.view.getter + 32
22  SwiftUI                       	       0x1b2a81074 MakeBody.value.getter + 68
23  SwiftUI                       	       0x1b26dad28 implicit closure #2 in implicit closure #1 in closure #1 in closure #1 in Attribute.init<A>(_:) + 68
24  AttributeGraph                	       0x1a8e63e30 AG::Graph::UpdateStack::update() + 484
25  AttributeGraph                	       0x1a8e64238 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 320
26  AttributeGraph                	       0x1a8e69164 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 380
27  AttributeGraph                	       0x1a8e79c88 AGGraphGetValue + 220
28  SwiftUI                       	       0x1b2e909cc _ConditionalContent<>.ChildView.content.getter + 60
29  SwiftUI                       	       0x1b2e90af4 _ConditionalContent<>.ChildView.value.getter + 260
30  SwiftUI                       	       0x1b2e90bdc protocol witness for Rule.value.getter in conformance _ConditionalContent<A, B><>.ChildView + 40
31  SwiftUI                       	       0x1b26dad28 implicit closure #2 in implicit closure #1 in closure #1 in closure #1 in Attribute.init<A>(_:) + 68
32  AttributeGraph                	       0x1a8e63e30 AG::Graph::UpdateStack::update() + 484
33  AttributeGraph                	       0x1a8e64238 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 320
34  AttributeGraph                	       0x1a8e69164 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 380
35  AttributeGraph                	       0x1a8e79c88 AGGraphGetValue + 220
36  SwiftUI                       	       0x1b2b7dd9c AnyViewList.updateValue() + 56
37  SwiftUI                       	       0x1b287bc94 partial apply for specialized implicit closure #2 in implicit closure #1 in closure #1 in closure #1 in Attribute.init<A>(_:) + 20
38  AttributeGraph                	       0x1a8e63e30 AG::Graph::UpdateStack::update() + 484
39  AttributeGraph                	       0x1a8e64238 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 320
40  AttributeGraph                	       0x1a8e69164 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 380
41  AttributeGraph                	       0x1a8e79c88 AGGraphGetValue + 220
42  SwiftUI                       	       0x1b2674360 specialized implicit closure #2 in implicit closure #1 in closure #1 in closure #1 in Attribute.init<A>(_:) + 92
43  AttributeGraph                	       0x1a8e63e30 AG::Graph::UpdateStack::update() + 484
44  AttributeGraph                	       0x1a8e64238 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 320
45  AttributeGraph                	       0x1a8e69164 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 380
46  AttributeGraph                	       0x1a8e79c88 AGGraphGetValue + 220
47  SwiftUI                       	       0x1b25a45b8 specialized ViewRootBody.list.getter + 84
48  SwiftUI                       	       0x1b2678560 specialized implicit closure #2 in implicit closure #1 in closure #1 in closure #1 in Attribute.init<A>(_:) + 60
49  AttributeGraph                	       0x1a8e63e30 AG::Graph::UpdateStack::update() + 484
50  AttributeGraph                	       0x1a8e64238 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 320
51  AttributeGraph                	       0x1a8e69164 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 380
52  AttributeGraph                	       0x1a8e79c88 AGGraphGetValue + 220
53  SwiftUI                       	       0x1b25a046c specialized StaticBody.container.getter + 32
54  SwiftUI                       	       0x1b25bb1e8 specialized StaticBody.value.getter + 592
55  SwiftUI                       	       0x1b26784ec specialized implicit closure #2 in implicit closure #1 in closure #1 in closure #1 in Attribute.init<A>(_:) + 28
56  AttributeGraph                	       0x1a8e63e30 AG::Graph::UpdateStack::update() + 484
57  AttributeGraph                	       0x1a8e64238 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 320
58  AttributeGraph                	       0x1a8e69164 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 380
59  AttributeGraph                	       0x1a8e79c88 AGGraphGetValue + 220
60  SwiftUI                       	       0x1b2659908 specialized _ConditionalContent<>.ChildView.content.getter + 44
61  SwiftUI                       	       0x1b265a3fc specialized _ConditionalContent<>.ChildView.value.getter + 36
62  SwiftUI                       	       0x1b267aea0 specialized implicit closure #2 in implicit closure #1 in closure #1 in closure #1 in Attribute.init<A>(_:) + 28
63  SwiftUI                       	       0x1b269b174 partial apply for specialized implicit closure #2 in implicit closure #1 in closure #1 in closure #1 in Attribute.init<A>(_:) + 24
64  AttributeGraph                	       0x1a8e63e30 AG::Graph::UpdateStack::update() + 484
65  AttributeGraph                	       0x1a8e64238 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 320
66  AttributeGraph                	       0x1a8e69164 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 380
67  AttributeGraph                	       0x1a8e79c88 AGGraphGetValue + 220
68  SwiftUI                       	       0x1b2b7dd9c AnyViewList.updateValue() + 56
69  SwiftUI                       	       0x1b287bc94 partial apply for specialized implicit closure #2 in implicit closure #1 in closure #1 in closure #1 in Attribute.init<A>(_:) + 20
70  AttributeGraph                	       0x1a8e63e30 AG::Graph::UpdateStack::update() + 484
71  AttributeGraph                	       0x1a8e64238 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 320
72  AttributeGraph                	       0x1a8e69164 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 380
73  AttributeGraph                	       0x1a8e79c88 AGGraphGetValue + 220
74  SwiftUI                       	       0x1b29e3dec DynamicLayoutViewAdaptor.updatedItems() + 60
75  SwiftUI                       	       0x1b277c4ac specialized DynamicContainerInfo.updateItems(disableTransitions:) + 64
76  SwiftUI                       	       0x1b277b53c specialized DynamicContainerInfo.updateValue() + 336
77  SwiftUI                       	       0x1b2866e20 partial apply for specialized implicit closure #2 in implicit closure #1 in closure #1 in closure #1 in Attribute.init<A>(_:) + 20
78  AttributeGraph                	       0x1a8e63e30 AG::Graph::UpdateStack::update() + 484
79  AttributeGraph                	       0x1a8e64238 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 320
80  AttributeGraph                	       0x1a8e69164 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 380
81  AttributeGraph                	       0x1a8e79c88 AGGraphGetValue + 220
82  SwiftUI                       	       0x1b28d41b4 DynamicPreferenceCombiner.info.getter + 92
83  SwiftUI                       	       0x1b28d4354 DynamicPreferenceCombiner.value.getter + 152
84  SwiftUI                       	       0x1b26dad28 implicit closure #2 in implicit closure #1 in closure #1 in closure #1 in Attribute.init<A>(_:) + 68
85  AttributeGraph                	       0x1a8e63e30 AG::Graph::UpdateStack::update() + 484
86  AttributeGraph                	       0x1a8e64238 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 320
87  AttributeGraph                	       0x1a8e68bb4 AG::Graph::value_ref(AG::AttributeID, AGSwiftMetadata const*, bool*) + 152
88  AttributeGraph                	       0x1a8e79cd0 AGGraphGetValue + 292
89  SwiftUI                       	       0x1b2e10378 GraphHost.updatePreferences() + 52
90  SwiftUI                       	       0x1b29c1a10 ViewGraph.updateOutputs(at:) + 100
91  SwiftUI                       	       0x1b2d80ff8 closure #1 in ViewRendererHost.render(interval:updateDisplayList:) + 1232
92  SwiftUI                       	       0x1b2d80530 ViewRendererHost.render(interval:updateDisplayList:) + 308
93  SwiftUI                       	       0x1b2ec3fc0 _UIHostingView.layoutSubviews() + 184
94  SwiftUI                       	       0x1b2ec3fec @objc _UIHostingView.layoutSubviews() + 24
95  UIKitCore                     	       0x18488e390 -[UIView(CALayerDelegate) layoutSublayersOfLayer:] + 2536
96  QuartzCore                    	       0x18758d350 -[CALayer layoutSublayers] + 288
97  QuartzCore                    	       0x187593764 CA::Layer::layout_if_needed(CA::Transaction*) + 504
98  QuartzCore                    	       0x18759e7f8 CA::Layer::layout_and_display_if_needed(CA::Transaction*) + 124
99  QuartzCore                    	       0x1874f6a0c CA::Context::commit_transaction(CA::Transaction*, double, double*) + 412
100 QuartzCore                    	       0x187520944 CA::Transaction::commit() + 732
101 UIKitCore                     	       0x1843aed48 __34-[UIApplication _firstCommitBlock]_block_invoke_2 + 80
102 CoreFoundation                	       0x1803786c4 __CFRUNLOOP_IS_CALLING_OUT_TO_A_BLOCK__ + 20
103 CoreFoundation                	       0x18037795c __CFRunLoopDoBlocks + 404
104 CoreFoundation                	       0x180372228 __CFRunLoopRun + 780
105 CoreFoundation                	       0x180371a0c CFRunLoopRunSpecific + 572
106 GraphicsServices              	       0x18ae17740 GSEventRunModal + 160
107 UIKitCore                     	       0x184392670 -[UIApplication _run] + 964
108 UIKitCore                     	       0x184397490 UIApplicationMain + 112
109 SwiftUI                       	       0x1b2db0808 closure #1 in KitRendererCommon(_:) + 108
110 SwiftUI                       	       0x1b2db0798 runApp<A>(_:) + 160
111 SwiftUI                       	       0x1b29bbac4 static App.main() + 80
112 GetOpaqueTypeMetadataSwiftUICrash	       0x1005b5804 static GetOpaqueTypeMetadataSwiftUICrashApp.$main() + 24 (GetOpaqueTypeMetadataSwiftUICrashApp.swift:5) [inlined]
113 GetOpaqueTypeMetadataSwiftUICrash	       0x1005b5804 main + 36
114 dyld                          	       0x1008a90f4 start + 520
```