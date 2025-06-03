import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors/colors.dart';
import '../constants/theme/theme_helper.dart';
import '../cubit/theme/theme_cubit.dart';
import '../cubit/theme/theme_state.dart';

class CustomTopAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomTopAppBar({super.key});

  @override
  _CustomTopAppBarState createState() => _CustomTopAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomTopAppBarState extends State<CustomTopAppBar> {
  String _selectedLanguage = 'English';
  bool _isShowingAll = false;

  final Map<String, String> _languageFlags = {
    'English': '🇺🇸',
    'Uzbek (Latin)': '🇺🇿',
    'Uzbek (Cyrillic)': '🇺🇿',
    'Russian': '🇷🇺',
  };
  bool _isDarkMode = false; // State ichida e'lon qilinadi



  final List<Map<String, String>> _notifications = [
    {'title': 'New login', 'time': '10 minutes ago', 'details': 'Someone logged in from a new device.'},
    {'title': 'New login', 'time': '38 minutes ago', 'details': 'Another device logged in.'},
    {'title': 'Application Approved', 'time': '2 days ago', 'details': 'Your loan application has been approved.'},
    {'title': 'Signer Approval Received', 'time': '2 days ago', 'details': 'Your document signer approved the document.'},
    {'title': 'Signer Approval Received', 'time': '3 days ago', 'details': 'Signer approval received for contract.'},
  ];

  late List<bool> _expandedStates;
  late List<bool> _readStates;

  @override
  void initState() {
    super.initState();
    _expandedStates = List<bool>.generate(_notifications.length, (_) => false);
    _readStates = List<bool>.generate(_notifications.length, (_) => false);
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
              Text(entry.value, style: const TextStyle(fontSize: 18)),
              const SizedBox(width: 8),
              Text(entry.key, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            ],
          ),
        );
      }).toList(),
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

    if (selected != null) {
      setState(() {
        _selectedLanguage = selected;
      });
    }
  }

  List<PopupMenuEntry> _notificationList(BuildContext context) {
    final displayCount = _isShowingAll ? _notifications.length : 2;

    return List.generate(
      displayCount > _notifications.length ? _notifications.length : displayCount,
          (index) {
        final notif = _notifications[index];

        return PopupMenuItem(
          enabled: false,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStateMenu) {
              final isExpanded = _expandedStates[index];
              final isRead = _readStates[index];

              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300), // Maksimal eni belgilandi
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notif['title']!,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: isRead ? Colors.grey[600] : Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '🕒 ${notif['time']!}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    if (isExpanded)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300), // Details uchun ham eni chegaralandi
                          child: Text(
                            notif['details'] ?? '',
                            style: const TextStyle(color: Colors.black87, fontSize: 13),
                            maxLines: 3, // Maksimal qatorlar soni
                            overflow: TextOverflow.ellipsis, // Agar uzun bo‘lsa, qisqartiriladi
                          ),
                        ),
                      ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          setStateMenu(() {
                            if (!isExpanded) {
                              _expandedStates[index] = true;
                              _readStates[index] = true;
                            } else {
                              _expandedStates[index] = false;
                            }
                            setState(() {}); // Asosiy holatni yangilash
                          });
                        },
                        child: Text(
                          isExpanded ? 'Hide Message' : 'View Message',
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showNotificationsMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero);
    final Size size = button.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + kToolbarHeight,
        offset.dx + 200,
        offset.dy,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          child: Container(
            width: 300, // Qat’iy eni belgilandi
            constraints: const BoxConstraints(maxHeight: 300),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Notifications',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _notifications.clear();
                            _expandedStates = [];
                            _readStates = [];
                            _isShowingAll = false;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Clear',
                          style: TextStyle(
                            color: Colors.purple,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  if (_notifications.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'No notifications',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    )
                  else
                    ..._notificationList(context),
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isShowingAll = !_isShowingAll; // Holatni o'zgartirish
                        });
                        Navigator.pop(context);
                        _showNotificationsMenu(context); // Menyuni qayta ochish
                      },
                      child: Text(
                        _isShowingAll ? 'Hide all' : 'View all',
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  void _showProfile(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero);
    final Size size = button.size;

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + kToolbarHeight,
        offset.dx + 200,
        offset.dy,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'SHOHBOZBEK TURG‘UNOV',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              SizedBox(height: 4),
              Text(
                'sh.turgunov@newuu.uz',
                style: TextStyle(fontSize: 13, color: Colors.black),
              ),
              Divider(),
            ],
          ),
        ),
        PopupMenuItem(
          child: Row(
            children: const [
              Icon(Icons.logout, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text('Sign Out', style: TextStyle(color: Colors.red)),
            ],
          ),
          onTap: () {
            // Logout funksiyasini shu yerda bajarish
            // Navigator.pushReplacement(...);
          },
        ),
      ],
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  @override
  Widget build(BuildContext context) {

    final theme = AppThemeHelper.of(context);


    return AppBar(
      foregroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.menu_open_outlined, color: theme.iconColor),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      actions: [
        BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            final isDarkMode = state.maybeWhen(
              darkMode: () => true,
              lightMode: () => false,
              orElse: () => false,
            );
            return IconButton(
              icon: Icon(
                isDarkMode ? Icons.dark_mode : Icons.wb_sunny,
                color: theme.iconColor,
              ),
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
            );
          },
        ),
        Builder(
          builder: (context) => ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => _showNotificationsMenu(context),
                splashColor: Colors.black12.withOpacity(0.3),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.notifications_none, color: theme.iconColor, size: 26),
                    if (unreadCount > 0)
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [Color(0xFF2A407A), Color(0xFF2A407A)!],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          constraints: const BoxConstraints(minWidth: 13, minHeight: 10),
                          child: Text(
                            unreadCount.toString(),
                            style:  TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Builder(
          builder: (context) => IconButton(
            icon: Text(_languageFlags[_selectedLanguage] ?? '🌐'),
            onPressed: () => _showLanguageMenu(context),
          ),
        ),
        Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Builder(
              builder: (context) {
                return InkWell(
                  borderRadius: BorderRadius.circular(50), // DUMALOQ bosiladigan zona
                  onTap: () => _showProfile(context),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8), // bu yerda dumaloqlik darajasi
                        child: Image.asset(
                          'assets/users_img/img.png',
                          width: 32,
                          height: 32,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],

    );
  }
}