import 'package:flutter/material.dart';

class CustomTopAppBar1 extends StatefulWidget implements PreferredSizeWidget {
  @override
  _CustomTopAppBar1State createState() => _CustomTopAppBar1State();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomTopAppBar1State extends State<CustomTopAppBar1> {
  String _selectedLanguage = 'English';

  final Map<String, String> _languageFlags = {
    'English': '🇺🇸',
    'Uzbek (Latin)': '🇺🇿',
    'Uzbek (Cyrillic)': '🇺🇿',
    'Russian': '🇷🇺',
  };

  List<Map<String, String>> notifications = [
    {'title': 'New login', 'time': '10 minutes ago', 'details': 'Someone logged in from a new device.'},
    {'title': 'New login', 'time': '38 minutes ago', 'details': 'Another device logged in.'},
    {'title': 'Application Approved', 'time': '2 days ago', 'details': 'Your loan application has been approved.'},
    {'title': 'Signer Approval Received', 'time': '2 days ago', 'details': 'Your document signer approved the document.'},
    {'title': 'Signer Approval Received', 'time': '3 days ago', 'details': 'Signer approval received for contract.'},
  ];

  late List<bool> _expandedStates;
  late List<bool> _readStates;

  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _expandedStates = List<bool>.generate(notifications.length, (_) => false, growable: true);
    _readStates = List<bool>.generate(notifications.length, (_) => false, growable: true);
  }

  int get unreadCount => _readStates.where((read) => !read).length;

  void _showLanguageMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero);

    final String? selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + kToolbarHeight,
        offset.dx + 200,
        offset.dy,
      ),
      items: _languageFlags.entries.map((entry) {
        return PopupMenuItem(
          value: entry.key,
          child: Row(
            children: [
              Text(entry.value),
              const SizedBox(width: 8),
              Text(entry.key),
            ],
          ),
        );
      }).toList(),
    );

    if (selected != null) {
      setState(() {
        _selectedLanguage = selected;
      });
    }
  }

  void _toggleNotificationExpanded(int index) {
    setState(() {
      if (!_expandedStates[index]) {
        _expandedStates[index] = true;
        _readStates[index] = true;
      } else {
        _expandedStates[index] = false;
      }
    });
  }

  void _clearNotifications() {
    setState(() {
      notifications.clear();
      _expandedStates.clear();
      _readStates.clear();
    });
    _removeOverlay();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showNotificationsOverlay(BuildContext context) {
    if (_overlayEntry != null) return; // Agar ochiq bo‘lsa yana ochma

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Size size = renderBox.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: offset.dy + size.height + 5,
        right: 10,
        width: 320,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            constraints: BoxConstraints(maxHeight: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: _clearNotifications,
                        child: Text('Clear', style: TextStyle(color: Colors.purple)),
                      ),
                    ],
                  ),
                ),
                Divider(height: 1),
                if (notifications.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text('No notifications'),
                  )
                else
                  Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notif = notifications[index];
                        final isExpanded = _expandedStates[index];
                        final isRead = _readStates[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              title: Text(
                                notif['title']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: isRead ? Colors.grey[600] : Colors.black,
                                ),
                              ),
                              subtitle: Text('🕒 ${notif['time']!}', style: TextStyle(fontSize: 12)),
                              trailing: !isRead
                                  ? Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                              )
                                  : null,
                            ),
                            if (isExpanded)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                child: Text(
                                  notif['details'] ?? '',
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, bottom: 8),
                              child: TextButton(
                                onPressed: () => _toggleNotificationExpanded(index),
                                child: Text(isExpanded ? 'Hide Message' : 'View Message'),
                              ),
                            ),
                            Divider(height: 1),
                          ],
                        );
                      },
                    ),
                  ),
                TextButton(
                  onPressed: () {
                    // Qo‘shimcha "View all" funksiyasi uchun joy
                  },
                  child: Text('View all'),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.grey[700]),
        onPressed: () {},
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.schedule, color: Colors.grey[700]),
          onPressed: () {},
        ),
        CompositedTransformTarget(
          link: _layerLink,
          child: Builder(
            builder: (context) => Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications_none, color: Colors.grey[700]),
                  onPressed: () {
                    if (_overlayEntry == null) {
                      _showNotificationsOverlay(context);
                    } else {
                      _removeOverlay();
                    }
                  },
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.blue[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(minWidth: 16, minHeight: 16),
                      child: Text(
                        unreadCount.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 10),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        Builder(
          builder: (context) => IconButton(
            icon: Text(_languageFlags[_selectedLanguage] ?? '🌐'),
            onPressed: () => _showLanguageMenu(context),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blueGrey,
                radius: 16,
                child: Icon(Icons.person, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 6),
              const Text(
                'SHOHBOZBEK',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}
