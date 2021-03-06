import 'package:flutter/material.dart';
import 'package:read_it_later/handlers/snackbar.handler.dart';
import 'package:read_it_later/screens/Library/library.controller.dart';
import 'package:read_it_later/screens/book_details.page.dart';
import 'package:read_it_later/services/HttpRequests.dart';

class NRCard extends StatefulWidget {
  final int id;
  final String bookTitle;
  final String bookAuthor;
  final String imageLink;
  final String selfLink;
  final String bookDescription;
  final String bookPublishedDate;
  final Icon icon;
  final bool activeIcon;

  const NRCard(
      {Key key,
      this.bookTitle,
      this.bookAuthor,
      this.imageLink,
      this.selfLink,
      this.icon,
      this.activeIcon,
      this.bookDescription,
      this.bookPublishedDate, this.id})
      : super(key: key);
  @override
  _NRCardState createState() => _NRCardState();
}

class _NRCardState extends State<NRCard> {
  bool _hasBeenPressed = false;

  handlerNRListTile() {
    setState(() {
      _hasBeenPressed = !_hasBeenPressed;
    });

    HttpRequests().fetchBook(link: widget.selfLink).then((value) {
      return LibraryController.instance.addBookInNextReading(item: value);
    });
    SnackBarHandler().showSnackbar(
      context: context,
      message:
          '${widget.bookTitle} foi adicionado a sua lista de próximas leituras',
    );
  }

  @override
  Widget build(BuildContext context) {
    // Validation if occur some error in return the Book widget
    final NRListTile = widget.bookTitle == '[error]'
        ? Container()
        : TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookDetailsPage(
                      
                      freeConclutedBooks: false,
                      freeNextReading: false,
                          id: widget.id,
                          title: widget.bookTitle ?? '\"Título desconhecido\"',
                          authors:
                              widget.bookAuthor ?? '\"Autor desconhecido\"',
                          description: widget.bookDescription ??
                              '\"Livro sem descrição\"',
                          image: widget.imageLink,
                          publishedDate:
                              widget.bookPublishedDate ?? '\"Desconhecida\"',
                          selfLink: widget.selfLink ??
                              '\"Link próprio desconhecido\"',
                        )),
              );
            },
            child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Colors.white24))),
                  child: Image.network('${widget.imageLink}'),
                ),
                title: Text(
                  "${widget.bookTitle}",
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyText1.color,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      "${widget.bookAuthor}",
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyText1.color,
                          fontWeight: FontWeight.w400),
                      overflow: TextOverflow.ellipsis,
                    ))
                  ],
                ),
                trailing: widget.activeIcon == true
                    ? IconButton(
                        icon: Icon(Icons.bookmark_outline_sharp),
                        color: _hasBeenPressed
                            ? Theme.of(context).accentColor
                            : Theme.of(context).textTheme.bodyText1.color,
                        iconSize: 30.0,
                        onPressed: handlerNRListTile)
                    : Container(width: 30, height: 30)));

    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(),
        child: NRListTile,
      ),
    );
  }
}
