import 'package:flutter/material.dart';
import 'package:market_nest_app/config/themes/app_color.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<PackageInfo> _packageInfoFuture;

  @override
  void initState() {
    super.initState();
    _packageInfoFuture = _loadPackageInfo();
  }

  Future<PackageInfo> _loadPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _buildProfileContent(),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    const profileUrl =
        'https://scontent.fpnh19-1.fna.fbcdn.net/v/t39.30808-6/453846779_1641392353383865_3619548638661995903_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeEUW9z93eWyYyoqV81v_XpTzXa7gB_2cizNdruAH_ZyLKx7W8bk_a8mA7XTXM4JGYkTDpUmr-yL7OF-xU54ZGEA&_nc_ohc=Lgp7FjZrDYgQ7kNvgF-Nsbh&_nc_ht=scontent.fpnh19-1.fna&oh=00_AYAtTIG1Apm-GuVyviV2VyADAupdqt6YLSz77lHkxyvTRg&oe=66C3ED27';

    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 175,
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: AppColors.cyan,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool isExpanded = constraints.biggest.height > 175;
          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(isExpanded ? 28 : 0),
            title: _buildProfileHeader(profileUrl, isExpanded),
            background: _buildHeaderBackground(),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(String profileUrl, bool isExpanded) {
    return Container(
      padding: EdgeInsets.only(
        left: isExpanded ? 5 : 20,
        bottom: isExpanded ? 25 : 25,
        top: isExpanded ? 25 : 0,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(profileUrl),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Judo / Houng',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'lyhoung244@gmail.com',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBackground() {
    return Container(
      color: AppColors.cyan,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 30,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent() {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Personal Information'),
              _buildProfileOption(Icons.location_on_outlined, 'Shipping Address'),
              const Divider(),
              _buildProfileOption(Icons.payment_outlined, 'Payment Method'),
              const Divider(),
              _buildProfileOption(Icons.history_outlined, 'Order History'),
              const Divider(),
              _buildSectionTitle('Support & Information'),
              _buildProfileOption(Icons.privacy_tip_outlined, 'Privacy Policy'),
              const Divider(),
              _buildProfileOption(Icons.description_outlined, 'Terms & Conditions'),
              const Divider(),
              _buildProfileOption(Icons.help_outline, 'FAQs'),
              const Divider(),
              _buildSectionTitle('Account Management'),
              _buildDarkThemeToggle(),
              const Divider(),
              _buildProfileOption(Icons.lock_outline, 'Change Password'),
              const Divider(),
              _buildProfileOption(Icons.language_outlined, 'Languages'),
              const Divider(),
              FutureBuilder<PackageInfo>(
                future: _packageInfoFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return _buildProfileOption(Icons.build_circle_outlined, 'Version', trailing: 'Loading...');
                  } else if (snapshot.hasError) {
                    return _buildProfileOption(Icons.build_circle_outlined, 'Version', trailing: 'Error');
                  } else {
                    return _buildProfileOption(Icons.build_circle_outlined, 'Version', trailing: snapshot.data?.version ?? 'Unknown');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildProfileOption(
    IconData icon,
    String title, {
    String trailing = '',
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title),
      trailing: trailing.isEmpty
          ? const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          : Text(trailing, style: const TextStyle(fontSize: 18)),
      onTap: () {      },
    );
  }

  Widget _buildDarkThemeToggle() {
    return SwitchListTile(
      value: false,
      onChanged: (value) {      },
      title: const Text('Dark Theme'),
      secondary: const Icon(Icons.dark_mode_outlined, color: Colors.grey),
    );
  }
}
