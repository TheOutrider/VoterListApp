// // ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace, use_key_in_widget_constructors, library_private_types_in_public_api

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:syncfusion_flutter_pdf/pdf.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// /// Represents the Homepage for Navigation
// class PdfPage extends StatefulWidget {

//   final String pdfUrl;
//   const PdfPage({Key? key, required this.pdfUrl}): super(key: key);
 

//   @override
//   _PdfPage createState() => _PdfPage();
// }

// class _PdfPage extends State<PdfPage> {
//   final PdfViewerController _pdfViewerController = PdfViewerController();
//   final GlobalKey<SearchToolbarState> _textSearchKey = GlobalKey();
//   late bool _showToolbar;
//   late bool _showScrollHead;

//   /// Ensure the entry history of Text search.
//   LocalHistoryEntry? _historyEntry;

//   @override
//   void initState() {
//     _showToolbar = false;
//     _showScrollHead = true;
//     super.initState();
//   }

//   /// Ensure the entry history of text search.
//   void _ensureHistoryEntry() {
//     if (_historyEntry == null) {
//       final ModalRoute<dynamic>? route = ModalRoute.of(context);
//       if (route != null) {
//         _historyEntry = LocalHistoryEntry(onRemove: _handleHistoryEntryRemoved);
//         route.addLocalHistoryEntry(_historyEntry!);
//       }
//     }
//   }

//   /// Remove history entry for text search.
//   void _handleHistoryEntryRemoved() {
//     _textSearchKey.currentState?.clearSearch();
//     setState(() {
//       _showToolbar = false;
//     });
//     _historyEntry = null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _showToolbar
//           ? AppBar(
//               flexibleSpace: SafeArea(
//                 child: SearchToolbar(
//                   key: _textSearchKey,
//                   showTooltip: true,
//                   pdfViewController: _pdfViewerController,
//                   onTap: (Object toolbarItem) async {
//                     if (toolbarItem.toString() == 'Cancel Search') {
//                       setState(() {
//                         _showToolbar = false;
//                         _showScrollHead = true;
//                         if (Navigator.canPop(context)) {
//                           Navigator.maybePop(context);
//                         }
//                       });
//                     }
//                     if (toolbarItem.toString() == 'noResultFound') {
//                       setState(() {
//                         _textSearchKey.currentState?._showToast = true;
//                       });
//                       await Future.delayed(Duration(seconds: 1));
//                       setState(() {
//                         _textSearchKey.currentState?._showToast = false;
//                       });
//                     }
//                   },
//                 ),
//               ),
//               automaticallyImplyLeading: false,
//               backgroundColor: Colors.grey[300],
//             )
//           : AppBar(
//               title: Text(
//                 'Search here',
//                 style: TextStyle(color: Colors.black87),
//               ),
//               backgroundColor: Colors.grey[300],
//               actions: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.search,
//                     color: Colors.black87,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _showScrollHead = false;
//                       _showToolbar = true;
//                       _ensureHistoryEntry();
//                     });
//                   },
//                 ),
//               ],
//               automaticallyImplyLeading: false,
//               // backgroundColor: Color(0xFFFAFAFA),
//             ),
//       body: Stack(
//         children: [
//           // SfPdfViewer.network(
//           //   'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
//           //   controller: _pdfViewerController,
//           //   canShowScrollHead: _showScrollHead,
//           // ),
//           SfPdfViewer.asset(
//             widget.pdfUrl,
//             controller: _pdfViewerController,
//             canShowScrollHead: _showScrollHead,
//           ),
//           Visibility(
//             visible: _textSearchKey.currentState?._showToast ?? false,
//             child: Align(
//               alignment: Alignment.center,
//               child: Flex(
//                 direction: Axis.horizontal,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     padding:
//                         EdgeInsets.only(left: 15, top: 7, right: 15, bottom: 7),
//                     decoration: BoxDecoration(
//                       color: Colors.grey[600],
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(16.0),
//                       ),
//                     ),
//                     child: Text(
//                       'No result',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                           fontFamily: 'Roboto',
//                           fontSize: 16,
//                           color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// Signature for the [SearchToolbar.onTap] callback.
// typedef SearchTapCallback = void Function(Object item);

// /// SearchToolbar widget
// class SearchToolbar extends StatefulWidget {
//   ///it describe the search toolbar constructor
//   SearchToolbar({
//     this.pdfViewController,
//     this.onTap,
//     this.showTooltip = true,
//     Key? key,
//   }) : super(key: key);

//   /// Indicates whether the tooltip for the search toolbar items need to be shown or not.
//   final bool showTooltip;
//   final PdfViewerController? pdfViewController;
//   final SearchTapCallback? onTap;

//   @override
//   SearchToolbarState createState() => SearchToolbarState();
// }

// /// State for the SearchToolbar widget
// class SearchToolbarState extends State<SearchToolbar> {
//   /// Indicates whether search is initiated or not.
//   bool _isSearchInitiated = false;

//   /// Indicates whether search toast need to be shown or not.
//   bool _showToast = false;

//   ///An object that is used to retrieve the current value of the TextField.
//   final TextEditingController _editingController = TextEditingController();

//   /// An object that is used to retrieve the text search result.
//   PdfTextSearchResult _pdfTextSearchResult = PdfTextSearchResult();

//   ///An object that is used to obtain keyboard focus and to handle keyboard events.
//   FocusNode? focusNode;

//   @override
//   void initState() {
//     super.initState();
//     focusNode = FocusNode();
//     focusNode?.requestFocus();
//   }

//   @override
//   void dispose() {
//     // Clean up the focus node when the Form is disposed.
//     focusNode?.dispose();
//     _pdfTextSearchResult.removeListener(() {});
//     super.dispose();
//   }

//   ///Clear the text search result
//   void clearSearch() {
//     _isSearchInitiated = false;
//     _pdfTextSearchResult.clear();
//   }

//   ///Display the Alert dialog to search from the beginning
//   void _showSearchAlertDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           insetPadding: EdgeInsets.all(0),
//           title: Text('Search Result'),
//           content: Container(
//               width: 328.0,
//               child: Text(
//                   'No more occurrences found. Would you like to continue to search from the beginning?')),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   _pdfTextSearchResult.nextInstance();
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'YES',
//                 style: TextStyle(
//                     color: Color(0x00000000).withOpacity(0.87),
//                     fontFamily: 'Roboto',
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                     decoration: TextDecoration.none),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   _pdfTextSearchResult.clear();
//                   _editingController.clear();
//                   _isSearchInitiated = false;
//                   focusNode?.requestFocus();
//                 });
//                 Navigator.of(context).pop();
//               },
//               child: Text(
//                 'NO',
//                 style: TextStyle(
//                     color: Color(0x00000000).withOpacity(0.87),
//                     fontFamily: 'Roboto',
//                     fontStyle: FontStyle.normal,
//                     fontWeight: FontWeight.w500,
//                     decoration: TextDecoration.none),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<List<int>> _readDocumentData(String name) async {
// final ByteData data = await rootBundle.load('assets/$name');
// return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
// }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: <Widget>[
//         Material(
//           color: Colors.transparent,
//           child: IconButton(
//             icon: Icon(
//               Icons.arrow_back,
//               color: Color(0x00000000).withOpacity(0.54),
//               size: 24,
//             ),
//             onPressed: () {
//               widget.onTap?.call('Cancel Search');
//               _isSearchInitiated = false;
//               _editingController.clear();
//               _pdfTextSearchResult.clear();
//             },
//           ),
//         ),
//         Flexible(
//           child: TextFormField(
//             style: TextStyle(
//                 color: Color(0x00000000).withOpacity(0.87), fontSize: 16),
//             enableInteractiveSelection: false,
//             focusNode: focusNode,
//             keyboardType: TextInputType.text,
//             textInputAction: TextInputAction.search,
//             controller: _editingController,
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintText: 'Find...',
//               hintStyle: TextStyle(color: Color(0x00000000).withOpacity(0.34)),
//             ),
//             onChanged: (text) {
//               // print("SEARCH TEXT HERE : $text आसिफ");
//               if (_editingController.text.isNotEmpty) {
//                 setState(() {
//                   // _editingController.text = 'आसिफ';
//                 });
//               }
//             },
//             onFieldSubmitted: (String value) async {
//               print("FIELD SUBMITTED : "+ value + " | " + _editingController.text);

//               PdfDocument document =
//               PdfDocument(inputBytes: await _readDocumentData('page1.pdf'));
//               PdfTextExtractor extractor = PdfTextExtractor(document);
 
//               //Extract all the text from the document.
//               String extractedText = extractor.extractText();
//               print("ALL PDF TEXT : " + extractedText);

//               // PdfTextExtractor textExtractor = PdfTextExtractor(widget.pdfViewController.);
//               // String pdfExtractedText = textExtractor.extractText(pageNumber);
//               // print("pdfExtractedText : "+ pdfExtractedText);

//               // if (kIsWeb) {
//               //   _pdfTextSearchResult =
//               //       widget.controller!.searchText(_editingController.text);
//               //   if (_pdfTextSearchResult.totalInstanceCount == 0) {
//               //     widget.onTap?.call('noResultFound');
//               //   }
//               //   setState(() {});
//               // } else {
//                 _isSearchInitiated = true;
//                 _pdfTextSearchResult =
//                     widget.pdfViewController!.searchText(1 ==1 ? 'यादीती' : _editingController.text);
                    
//                 _pdfTextSearchResult.addListener(() {
//                   if (super.mounted) {
//                     setState(() {});
//                   }
//                   if (!_pdfTextSearchResult.hasResult &&
//                       _pdfTextSearchResult.isSearchCompleted) {
//                     widget.onTap?.call('noResultFound');
//                   }
//                 });
//               // }
//             },
//           ),
//         ),
//         Visibility(
//           visible: _editingController.text.isNotEmpty,
//           child: Material(
//             color: Colors.transparent,
//             child: IconButton(
//               icon: Icon(
//                 Icons.clear,
//                 color: Color.fromRGBO(0, 0, 0, 0.54),
//                 size: 24,
//               ),
//               onPressed: () {
//                 setState(() {
//                   _editingController.clear();
//                   _pdfTextSearchResult.clear();
//                   widget.pdfViewController!.clearSelection();
//                   _isSearchInitiated = false;
//                   focusNode!.requestFocus();
//                 });
//                 widget.onTap!.call('Clear Text');
//               },
//               tooltip: widget.showTooltip ? 'Clear Text' : null,
//             ),
//           ),
//         ),
//         Visibility(
//           visible:
//               !_pdfTextSearchResult.isSearchCompleted && _isSearchInitiated,
//           child: Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: SizedBox(
//               width: 24,
//               height: 24,
//               child: CircularProgressIndicator(
//                 color: Theme.of(context).primaryColor,
//               ),
//             ),
//           ),
//         ),
//         Visibility(
//           visible: _pdfTextSearchResult.hasResult,
//           child: Row(
//             children: [
//               Text(
//                 '${_pdfTextSearchResult.currentInstanceIndex}',
//                 style: TextStyle(
//                     color: Color.fromRGBO(0, 0, 0, 0.54).withOpacity(0.87),
//                     fontSize: 16),
//               ),
//               Text(
//                 ' of ',
//                 style: TextStyle(
//                     color: Color.fromRGBO(0, 0, 0, 0.54).withOpacity(0.87),
//                     fontSize: 16),
//               ),
//               Text(
//                 '${_pdfTextSearchResult.totalInstanceCount}',
//                 style: TextStyle(
//                     color: Color.fromRGBO(0, 0, 0, 0.54).withOpacity(0.87),
//                     fontSize: 16),
//               ),
//               Material(
//                 color: Colors.transparent,
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.navigate_before,
//                     color: Color.fromRGBO(0, 0, 0, 0.54),
//                     size: 24,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _pdfTextSearchResult.previousInstance();
//                     });
//                     widget.onTap!.call('Previous Instance');
//                   },
//                   tooltip: widget.showTooltip ? 'Previous' : null,
//                 ),
//               ),
//               Material(
//                 color: Colors.transparent,
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.navigate_next,
//                     color: Color.fromRGBO(0, 0, 0, 0.54),
//                     size: 24,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       if (_pdfTextSearchResult.currentInstanceIndex ==
//                               _pdfTextSearchResult.totalInstanceCount &&
//                           _pdfTextSearchResult.currentInstanceIndex != 0 &&
//                           _pdfTextSearchResult.totalInstanceCount != 0 &&
//                           _pdfTextSearchResult.isSearchCompleted) {
//                         _showSearchAlertDialog(context);
//                       } else {
//                         widget.pdfViewController!.clearSelection();
//                         _pdfTextSearchResult.nextInstance();
//                       }
//                     });
//                     widget.onTap!.call('Next Instance');
//                   },
//                   tooltip: widget.showTooltip ? 'Next' : null,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
