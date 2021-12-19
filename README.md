# Demo project of Swift language crash using Release build on iOS 14

## Repro steps

1. Open `GetOpaqueTypeMetadataSwiftUICrash.xcodeproj`
2. Product -> Profile
3. Run the app on 

## Crashing Snippet

```swift
public extension View {
  @ViewBuilder
  func searchableFor15(text: Binding<String>) -> some View {
    if #available(iOS 15, *) {
      searchable(text: text)
    } else {
      self
    }
  }
}
```

## Crash Stack (Simulator)

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

## Crash Stack (device, iPhone 6s Plus, iOS 14.7.1)

```
Exception Type:  EXC_BAD_ACCESS (SIGSEGV)
Exception Codes:  at 
Crashed Thread:  0

Thread 0 Crashed:
0   libswiftCore.dylib                   0x000000019b6ba27c swift_getOpaqueTypeMetadata + 36
1   FooAppUI                             0x000000010567ca38 (extension in FooAppUI):SwiftUI.View.searchableFor15(text: SwiftUI.Binding<Swift.String>) -> some (<compiler-generated>:0)
2   FooAppUI                             0x000000010567ca38 (extension in FooAppUI):SwiftUI.View.searchableFor15(text: SwiftUI.Binding<Swift.String>) -> some (<compiler-generated>:0)
3   IFSharedUI                           0x0000000104374908 IFSharedUI.FolderChooserView.body.getter : some (FolderChooserView.swift:53)
4   SwiftUI                              0x000000019de21884 partial apply forwarder for closure #1 () -> A.Body in SwiftUI.ViewBodyAccessor.updateBody(of: A, changed: Swift.Bool) -> () + 24
5   SwiftUI                              0x000000019e139364 closure #1 () -> A.Body in (extension in SwiftUI):SwiftUI.BodyAccessor.setBody(() -> A.Body) -> () + 40
6   SwiftUI                              0x000000019de1af78 SwiftUI.ViewBodyAccessor.updateBody(of: A, changed: Swift.Bool) -> () + 1392
7   SwiftUI                              0x000000019e139770 SwiftUI.DynamicBody.updateValue() -> () + 440
8   SwiftUI                              0x000000019de3c764 partial apply forwarder for implicit closure #2 (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in implicit closure #1 (A1.Type) -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 () -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 (Swift.UnsafePointer<A1>) -> AttributeGraph.Attribute<A> in AttributeGraph.Attribute.init<A where A == A1.Value, A1: AttributeGraph.StatefulRule>(A1) -> AttributeGraph.Attribute<A> + 24
9   AttributeGraph                       0x00000001beffb108 AG::Graph::UpdateStack::update() + 480
10  AttributeGraph                       0x00000001beffb518 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 324
11  AttributeGraph                       0x00000001bf000718 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 356
12  AttributeGraph                       0x00000001bf0113c0 AGGraphGetValue + 224
13  SwiftUI                              0x000000019e47fc80 (extension in SwiftUI):SwiftUI._ConditionalContent< where A: SwiftUI.View, B: SwiftUI.View>.(ChildView in _1A625ACC143FD8524C590782FD8F4F8C).content.getter : SwiftUI._ConditionalContent<A, B> + 56
14  SwiftUI                              0x000000019e47fe20 (extension in SwiftUI):SwiftUI._ConditionalContent< where A: SwiftUI.View, B: SwiftUI.View>.(ChildView in _1A625ACC143FD8524C590782FD8F4F8C).value.getter : SwiftUI.AnyView + 376
15  SwiftUI                              0x000000019e47ff30 protocol witness for AttributeGraph.Rule.value.getter : A.Value in conformance (extension in SwiftUI):SwiftUI._ConditionalContent<A, B>< where A: SwiftUI.View, B: SwiftUI.View>.(ChildView in _1A625ACC143FD8524C590782FD8F4F8C) : AttributeGraph.Rule in SwiftUI + 36
16  SwiftUI                              0x000000019dd4b6e0 implicit closure #2 (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in implicit closure #1 (A1.Type) -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 () -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 (Swift.UnsafePointer<A1>) -> AttributeGraph.Attribute<A> in AttributeGraph.Attribute.init<A where A == A1.Value, A1: AttributeGraph.Rule>(A1) -> AttributeGraph.Attribute<A> + 156
17  AttributeGraph                       0x00000001beffb108 AG::Graph::UpdateStack::update() + 480
18  AttributeGraph                       0x00000001beffb518 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 324
19  AttributeGraph                       0x00000001bf000718 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 356
20  AttributeGraph                       0x00000001bf0113c0 AGGraphGetValue + 224
21  SwiftUI                              0x000000019e13cec8 SwiftUI.(AnyViewList in _A96961F3546506F21D8995C6092F15B5).updateValue() -> () + 52
22  SwiftUI                              0x000000019dd12f0c partial apply forwarder for generic specialization <SwiftUI.ViewList, SwiftUI.(AnyViewList in _A96961F3546506F21D8995C6092F15B5)> of implicit closure #2 (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in implicit closure #1 (A1.Type) -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 () -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 (Swift.UnsafePointer<A1>) -> AttributeGraph.Attribute<A> in AttributeGraph.Attribute.init<A where A == A1.Value, A1: AttributeGraph.StatefulRule>(A1) -> AttributeGraph.Attribute<A> + 16
23  AttributeGraph                       0x00000001beffb108 AG::Graph::UpdateStack::update() + 480
24  AttributeGraph                       0x00000001beffb518 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 324
25  AttributeGraph                       0x00000001bf000718 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 356
26  AttributeGraph                       0x00000001bf0113c0 AGGraphGetValue + 224
27  SwiftUI                              0x000000019df731e8 SwiftUI.(DynamicLayoutViewAdaptor in _8B9C7F39264416187A895085215951BC).updatedItems() -> SwiftUI.ViewList? + 56
28  SwiftUI                              0x000000019db59ac4 generic specialization <SwiftUI.(DynamicLayoutViewAdaptor in _8B9C7F39264416187A895085215951BC)> of SwiftUI.DynamicContainerInfo.(updateItems in _023AA827B8A8D39774F7A0C281455FEE)(disableTransitions: Swift.Bool) -> (changed: Swift.Bool, hasDepth: Swift.Bool) + 60
29  SwiftUI                              0x000000019db58854 generic specialization <SwiftUI.(DynamicLayoutViewAdaptor in _8B9C7F39264416187A895085215951BC)> of SwiftUI.DynamicContainerInfo.updateValue() -> () + 340
30  SwiftUI                              0x000000019dcd624c partial apply forwarder for generic specialization <SwiftUI.DynamicContainer.Info, SwiftUI.DynamicContainerInfo<SwiftUI.(DynamicLayoutViewAdaptor in _8B9C7F39264416187A895085215951BC)>> of implicit closure #2 (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in implicit closure #1 (A1.Type) -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 () -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 (Swift.UnsafePointer<A1>) -> AttributeGraph.Attribute<A> in AttributeGraph.Attribute.init<A where A == A1.Value, A1: AttributeGraph.StatefulRule>(A1) -> AttributeGraph.Attribute<A> + 16
31  AttributeGraph                       0x00000001beffb108 AG::Graph::UpdateStack::update() + 480
32  AttributeGraph                       0x00000001beffb518 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 324
33  AttributeGraph                       0x00000001bf000718 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 356
34  AttributeGraph                       0x00000001bf0113c0 AGGraphGetValue + 224
35  SwiftUI                              0x000000019de35b5c SwiftUI.(DynamicPreferenceCombiner in _023AA827B8A8D39774F7A0C281455FEE).info.getter : SwiftUI.DynamicContainer.Info? + 88
36  SwiftUI                              0x000000019de35d00 SwiftUI.(DynamicPreferenceCombiner in _023AA827B8A8D39774F7A0C281455FEE).value.getter : A.Value + 152
37  SwiftUI                              0x000000019dd4b6e0 implicit closure #2 (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in implicit closure #1 (A1.Type) -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 () -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 (Swift.UnsafePointer<A1>) -> AttributeGraph.Attribute<A> in AttributeGraph.Attribute.init<A where A == A1.Value, A1: AttributeGraph.Rule>(A1) -> AttributeGraph.Attribute<A> + 156
38  AttributeGraph                       0x00000001beffb108 AG::Graph::UpdateStack::update() + 480
39  AttributeGraph                       0x00000001beffb518 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 324
40  AttributeGraph                       0x00000001bf000718 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 356
41  AttributeGraph                       0x00000001bf0113c0 AGGraphGetValue + 224
42  SwiftUI                              0x000000019e0e4510 SwiftUI.(HostPreferencesTransform in _5EC2B8E51282B711F818D51701767C64).updateValue() -> () + 80
43  SwiftUI                              0x000000019de3c764 partial apply forwarder for implicit closure #2 (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in implicit closure #1 (A1.Type) -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 () -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 (Swift.UnsafePointer<A1>) -> AttributeGraph.Attribute<A> in AttributeGraph.Attribute.init<A where A == A1.Value, A1: AttributeGraph.StatefulRule>(A1) -> AttributeGraph.Attribute<A> + 24
44  AttributeGraph                       0x00000001beffb108 AG::Graph::UpdateStack::update() + 480
45  AttributeGraph                       0x00000001beffb518 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 324
46  AttributeGraph                       0x00000001bf000718 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 356
47  AttributeGraph                       0x00000001bf0113c0 AGGraphGetValue + 224
48  SwiftUI                              0x000000019e0e4510 SwiftUI.(HostPreferencesTransform in _5EC2B8E51282B711F818D51701767C64).updateValue() -> () + 80
49  SwiftUI                              0x000000019de3c764 partial apply forwarder for implicit closure #2 (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in implicit closure #1 (A1.Type) -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 () -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 (Swift.UnsafePointer<A1>) -> AttributeGraph.Attribute<A> in AttributeGraph.Attribute.init<A where A == A1.Value, A1: AttributeGraph.StatefulRule>(A1) -> AttributeGraph.Attribute<A> + 24
50  AttributeGraph                       0x00000001beffb108 AG::Graph::UpdateStack::update() + 480
51  AttributeGraph                       0x00000001beffb518 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 324
52  AttributeGraph                       0x00000001bf000718 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 356
53  AttributeGraph                       0x00000001bf0113c0 AGGraphGetValue + 224
54  SwiftUI                              0x000000019e0e4510 SwiftUI.(HostPreferencesTransform in _5EC2B8E51282B711F818D51701767C64).updateValue() -> () + 80
55  SwiftUI                              0x000000019de3c764 partial apply forwarder for implicit closure #2 (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in implicit closure #1 (A1.Type) -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 () -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 (Swift.UnsafePointer<A1>) -> AttributeGraph.Attribute<A> in AttributeGraph.Attribute.init<A where A == A1.Value, A1: AttributeGraph.StatefulRule>(A1) -> AttributeGraph.Attribute<A> + 24
56  AttributeGraph                       0x00000001beffb108 AG::Graph::UpdateStack::update() + 480
57  AttributeGraph                       0x00000001beffb518 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 324
58  AttributeGraph                       0x00000001bf000718 AG::Graph::input_value_ref_slow(AG::data::ptr<AG::Node>, AG::AttributeID, unsigned int, AGSwiftMetadata const*, bool*, long) + 356
59  AttributeGraph                       0x00000001bf0113c0 AGGraphGetValue + 224
60  SwiftUI                              0x000000019e3eaf50 SwiftUI.(HostPreferencesWriter in _A6D97EE78BF830A4822C799DA3BFF241).updateValue() -> () + 280
61  SwiftUI                              0x000000019de3c764 partial apply forwarder for implicit closure #2 (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in implicit closure #1 (A1.Type) -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 () -> (Swift.UnsafeMutableRawPointer, __C.AGAttribute) -> () in closure #1 (Swift.UnsafePointer<A1>) -> AttributeGraph.Attribute<A> in AttributeGraph.Attribute.init<A where A == A1.Value, A1: AttributeGraph.StatefulRule>(A1) -> AttributeGraph.Attribute<A> + 24
62  AttributeGraph                       0x00000001beffb108 AG::Graph::UpdateStack::update() + 480
63  AttributeGraph                       0x00000001beffb518 AG::Graph::update_attribute(AG::data::ptr<AG::Node>, bool) + 324
64  AttributeGraph                       0x00000001bf0001a8 AG::Graph::value_ref(AG::AttributeID, AGSwiftMetadata const*, bool*) + 148
65  AttributeGraph                       0x00000001bf011408 AGGraphGetValue + 296
66  SwiftUI                              0x000000019e3f6f38 SwiftUI.GraphHost.preferenceValues() -> SwiftUI.PreferenceList + 52
67  SwiftUI                              0x000000019e35ccec generic specialization <SwiftUI.NavigationTitleKey> of SwiftUI.GraphHost.preferenceValue<A where A: SwiftUI.HostPreferenceKey>(A.Type) -> A.Value + 104
68  SwiftUI                              0x000000019e357acc merged function signature specialization <Arg[1] = [Closure Propagated : generic specialization <SwiftUI._UIHostingView<SwiftUI._VariadicView_Children.Element>, SwiftUI.NavigationTitleKey> of closure #1 (SwiftUI.ViewGraph) -> A1.Value in (extension in SwiftUI):SwiftUI.ViewRendererHost.preferenceValue<A where A1: SwiftUI.HostPreferenceKey>(A1.Type) -> A1.Value, Argument Types : [@thick SwiftUI.NavigationTitleKey.Type]> of generic specialization <SwiftUI._UIHostingView<SwiftUI._VariadicView_Children.Element>, SwiftUI.NavigationTitleStorage?> of (extension in SwiftUI):SwiftUI.ViewRendererHost.updateViewGraph<A>(body: (SwiftUI.ViewGraph) -> A1) -> A1 + 96
69  SwiftUI                              0x000000019db7163c generic specialization <SwiftUI._VariadicView_Children.Element> of closure #1 () -> () in (extension in SwiftUI):__C.UINavigationController.update<A where A: SwiftUI.View>(with: A, in: SwiftUI.EnvironmentValues) -> () + 80
70  SwiftUI                              0x000000019df69f40 reabstraction thunk helper from @escaping @callee_guaranteed () -> () to @escaping @callee_guaranteed () -> (@out ()) + 16
71  SwiftUI                              0x000000019df56234 static SwiftUI.Update.end() -> () + 492
72  SwiftUI                              0x000000019e357b44 (extension in SwiftUI):SwiftUI.ViewRendererHost.updateViewGraph<A>(body: (SwiftUI.ViewGraph) -> A1) -> A1 + 84
73  SwiftUI                              0x000000019e35a0e8 (extension in SwiftUI):SwiftUI.ViewRendererHost.sizeThatFits(SwiftUI._ProposedSize) -> __C.CGSize + 104
74  SwiftUI                              0x000000019e4b50b0 SwiftUI._UIHostingView.sizeThatFits(__C.CGSize) -> __C.CGSize + 108
75  SwiftUI                              0x000000019e4b50f8 merged @objc SwiftUI._UIHostingView._baselineOffsets(at: __C.CGSize) -> __C._UIBaselineOffsetPair + 44
76  UIKitCore                            0x000000019a05e0f8 -[UIView(_UIConstraintBasedLayoutEmbedding) _layoutSizeThatFits:fixedAxes:] + 80
77  UIKitCore                            0x000000019a6f2054 -[UIView(UIConstraintBasedLayout) intrinsicContentSize] + 88
78  UIKitCore                            0x000000019a6f27d8 -[UIView(UIConstraintBasedLayout) _generateContentSizeConstraints] + 48
79  UIKitCore                            0x000000019a6f24e8 -[UIView(UIConstraintBasedLayout) _updateContentSizeConstraints] + 336
80  UIKitCore                            0x000000019a6fbfe8 -[UIView(AdditionalLayoutSupport) _updateSystemConstraints] + 120
81  UIKitCore                            0x000000019a6fadb4 -[UIView(AdditionalLayoutSupport) _sendUpdateConstraintsIfNecessaryForSecondPass:] + 476
82  UIKitCore                            0x000000019a6fb268 -[UIView(AdditionalLayoutSupport) _updateConstraintsIfNeededCollectingViews:forSecondPass:] + 940
83  UIKitCore                            0x000000019a6fb148 -[UIView(AdditionalLayoutSupport) _updateConstraintsIfNeededCollectingViews:forSecondPass:] + 652
84  CoreAutoLayout                       0x00000001aba30f50 -[NSISEngine withBehaviors:performModifications:] + 76
85  UIKitCore                            0x000000019a6fb478 -[UIView(AdditionalLayoutSupport) _recursiveUpdateConstraintsIfNeededCollectingViews:forSecondPass:] + 116
86  UIKitCore                            0x000000019a6fb148 -[UIView(AdditionalLayoutSupport) _updateConstraintsIfNeededCollectingViews:forSecondPass:] + 652
87  UIKitCore                            0x000000019a6fb148 -[UIView(AdditionalLayoutSupport) _updateConstraintsIfNeededCollectingViews:forSecondPass:] + 652
88  UIKitCore                            0x000000019a6fb148 -[UIView(AdditionalLayoutSupport) _updateConstraintsIfNeededCollectingViews:forSecondPass:] + 652
89  UIKitCore                            0x000000019a6fb148 -[UIView(AdditionalLayoutSupport) _updateConstraintsIfNeededCollectingViews:forSecondPass:] + 652
90  UIKitCore                            0x000000019a6fb148 -[UIView(AdditionalLayoutSupport) _updateConstraintsIfNeededCollectingViews:forSecondPass:] + 652
91  CoreAutoLayout                       0x00000001aba30f50 -[NSISEngine withBehaviors:performModifications:] + 76
92  UIKitCore                            0x000000019a6fb920 __100-[UIView(AdditionalLayoutSupport) _updateConstraintsIfNeededWithViewForVariableChangeNotifications:]_block_invoke + 84
93  UIKitCore                            0x000000019a6fa344 -[UIView(AdditionalLayoutSupport) _withUnsatisfiableConstraintsLoggingSuspendedIfEngineDelegateExists:] + 116
94  UIKitCore                            0x000000019a6fb56c -[UIView(AdditionalLayoutSupport) _updateConstraintsIfNeededWithViewForVariableChangeNotifications:] + 156
95  UIKitCore                            0x000000019a6ecedc -[UIWindow(UIConstraintBasedLayout) _updateConstraintsIfNeededWithViewForVariableChangeNotifications:] + 88
96  UIKitCore                            0x000000019a6fc548 -[UIView(AdditionalLayoutSupport) _updateConstraintsAtEngineLevelIfNeededWithViewForVariableChangeNotifications:] + 428
97  UIKitCore                            0x000000019a7ccb40 -[UIView(Hierarchy) layoutBelowIfNeeded] + 856
98  UIKitCore                            0x0000000199b20800 -[_UISheetPresentationController _sheetLayoutInfoLayout:] + 44
99  UIKitCore                            0x0000000199b1cc24 -[_UISheetLayoutInfo _layout] + 308
100 UIKitCore                            0x0000000199b22640 __54-[_UISheetPresentationController transitionWillBegin:]_block_invoke_2 + 48
101 UIKitCore                            0x000000019a7d329c +[UIView(Animation) performWithoutAnimation:] + 92
102 UIKitCore                            0x0000000199b22574 __54-[_UISheetPresentationController transitionWillBegin:]_block_invoke.362 + 124
103 UIKitCore                            0x0000000199c46754 -[_UIViewControllerTransitionCoordinator _applyBlocks:releaseBlocks:] + 260
104 UIKitCore                            0x0000000199c43240 -[_UIViewControllerTransitionContext __runAlongsideAnimations] + 256
105 UIKitCore                            0x000000019a7d306c __63+[UIView(Animation) _setAlongsideAnimations:toRunByEndOfBlock:]_block_invoke + 24
106 UIKitCore                            0x000000019a7a84e0 -[UIViewAnimationState _runAlongsideAnimations] + 28
107 UIKitCore                            0x000000019a7a73e8 -[UIViewAnimationState pop] + 48
108 UIKitCore                            0x000000019a7a4bb4 +[UIViewAnimationState popAnimationState] + 60
109 UIKitCore                            0x000000019a7d49d8 +[UIView _setupAnimationWithDuration:delay:view:options:factory:animations:start:animationStateGenerator:completion:] + 644
110 UIKitCore                            0x000000019a7d5094 +[UIView(UIViewAnimationWithBlocks) conditionallyAnimate:withAnimation:layout:completion:] + 84
111 UIKitCore                            0x000000019a7a0358 -[UITransitionView _startTransition:withDuration:] + 588
112 UIKitCore                            0x000000019a79fe80 -[UITransitionView transition:fromView:toView:removeFromView:] + 2412
113 UIKitCore                            0x0000000199c3f2bc -[UIViewControllerBuiltinTransitionViewAnimator animateTransition:] + 1472
114 UIKitCore                            0x0000000199c4729c ___UIViewControllerTransitioningRunCustomTransition_block_invoke_2 + 68
115 UIKitCore                            0x0000000199d75558 +[UIInputResponderController _pinInputViewsForInputResponderController:onBehalfOfResponder:duringBlock:] + 100
116 UIKitCore                            0x0000000199c4721c ___UIViewControllerTransitioningRunCustomTransition_block_invoke.641 + 172
117 UIKitCore                            0x000000019a7d2f70 +[UIView(Animation) _setAlongsideAnimations:toRunByEndOfBlock:] + 168
118 UIKitCore                            0x0000000199c47084 _UIViewControllerTransitioningRunCustomTransition + 568
119 UIKitCore                            0x0000000199b0e098 __56-[UIPresentationController runTransitionForCurrentState]_block_invoke.466 + 2196
120 UIKitCore                            0x000000019a77fee4 -[_UIAfterCACommitBlock run] + 60
121 UIKitCore                            0x000000019a2ef9c4 _runAfterCACommitDeferredBlocks + 292
122 UIKitCore                            0x000000019a2dee90 _cleanUpAfterCAFlushAndRunDeferredBlocks + 196
123 UIKitCore                            0x000000019a3101e0 _afterCACommitHandler + 72
124 CoreFoundation                       0x00000001979b9540 __CFRUNLOOP_IS_CALLING_OUT_TO_AN_OBSERVER_CALLBACK_FUNCTION__ + 28
125 CoreFoundation                       0x00000001979b3b70 __CFRunLoopDoObservers + 584
126 CoreFoundation                       0x00000001979b410c __CFRunLoopRun + 1008
127 CoreFoundation                       0x00000001979b37d0 CFRunLoopRunSpecific + 568
128 GraphicsServices                     0x00000001ae0f5570 GSEventRunModal + 156
129 UIKitCore                            0x000000019a2e02d0 -[UIApplication _run] + 1048
130 UIKitCore                            0x000000019a2e584c UIApplicationMain + 160
131 FooApp                               0x0000000102622744 main (AppDelegate.swift:16)
132 libdyld.dylib                        0x0000000197692140 start + 0
```
