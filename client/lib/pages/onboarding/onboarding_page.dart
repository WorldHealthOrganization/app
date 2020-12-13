import 'package:provider/provider.dart';
import 'package:who_app/api/content/content_store.dart';
import 'package:who_app/api/iso_country.dart';
import 'package:who_app/api/user_preferences.dart';
import 'package:who_app/api/user_preferences_store.dart';
import 'package:who_app/api/who_service.dart';
import 'package:who_app/pages/onboarding/country_list_page.dart';
import 'package:who_app/pages/onboarding/country_select_page.dart';
import 'package:who_app/pages/onboarding/legal_landing_page.dart';
import 'package:who_app/pages/onboarding/notifications_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key key, @required this.service, @required this.prefs})
      : super(key: key);

  final WhoService service;
  final UserPreferencesStore prefs;

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  static const _animationDuration = Duration(milliseconds: 500);
  static const _animationCurve = Curves.easeInOut;

  final PageController _pageController = PageController();

  IsoCountry _selectedCountry;
  bool _showCountryListPage = true;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //setupCountries();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final countryList = Provider.of<IsoCountryList>(context);
    if (_selectedCountry == null && countryList.countries.isNotEmpty) {
      // On first load of country list, the default is the locale country.
      final currentCountryCode = Localizations.localeOf(context).countryCode;
      if (mounted) {
        setState(() {
          _selectedCountry = countryList.countries[currentCountryCode];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ContentStore>(context);
    final countryList = Provider.of<IsoCountryList>(context);
    return WillPopScope(
      onWillPop: () async {
        // If a previous page exists
        if (_pageController.hasClients && _pageController.page > 0) {
          await _pageController.previousPage(
            duration: _animationDuration,
            curve: _animationCurve,
          );
          // Veto this back-press, we already went to previous page
          return false;
        }

        return true;
      },
      child: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          LegalLandingPage(onNext: () => _onLegalDone(store)),
          CountrySelectPage(
            onOpenCountryList: () async {
              await setState(() {
                _showCountryListPage = true;
              });
              await _toNextPage();
            },
            onNext: _onChooseCountry,
            countryName: _selectedCountry?.name,
          ),
          if (_showCountryListPage)
            CountryListPage(
              countries: countryList.countries,
              onBack: _toPreviousPage,
              selectedCountryCode: _selectedCountry?.alpha2Code,
              onCountrySelected: _selectCountry,
            ),
          NotificationsPage(onNext: _onDone),
        ],
      ),
    );
  }

  void _selectCountry(IsoCountry country) async {
    _selectedCountry = country;
    await setState(() {});
    await _toPreviousPage();
  }

  Future<void> _onChooseCountry() async {
    await widget.prefs.setCountryIsoCode(_selectedCountry.alpha2Code);
    await setState(() {
      _showCountryListPage = false;
    });
    await _toNextPage();
    var fcmToken = await UserPreferences().getFirebaseToken();
    try {
      await widget.service.putClientSettings(
          token: fcmToken, isoCountryCode: _selectedCountry.alpha2Code);
    } catch (error) {
      print('Error sending client settings to API: $error');
    }
  }

  Future<void> _onLegalDone(ContentStore store) async {
    await UserPreferences().setTermsOfServiceCompleted(true);
    // Enable auto init so that analytics will work
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    if (!await UserPreferences().getOnboardingCompleted() ||
        await UserPreferences().getAnalyticsEnabled()) {
      await UserPreferences().setAnalyticsEnabled(true);
    }

    // ignore: unawaited_futures
    store.update();

    await _toNextPage();
  }

  Future<void> _toPreviousPage() async {
    await _pageController.previousPage(
      duration: _animationDuration,
      curve: _animationCurve,
    );
  }

  Future<void> _toNextPage() async {
    await _pageController.nextPage(
      duration: _animationDuration,
      curve: _animationCurve,
    );
  }

  void _onDone() async {
    await UserPreferences().setOnboardingCompletedV1(true);
    await Navigator.of(context, rootNavigator: true).pushReplacementNamed(
      '/home',
    );
  }
}
