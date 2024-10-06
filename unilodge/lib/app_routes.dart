import 'package:go_router/go_router.dart';
import 'package:unilodge/data/dummy_data/dummy_data.dart';
import 'package:unilodge/presentation/screens/auth/account_selection_login.dart';
import 'package:unilodge/presentation/screens/auth/account_selection_sign_up.dart';
import 'package:unilodge/presentation/screens/auth/forget_password.dart';
import 'package:unilodge/presentation/screens/auth/login.dart';
import 'package:unilodge/presentation/screens/auth/sign_up.dart';
import 'package:unilodge/presentation/screens/auth/verify_email.dart';
import 'package:unilodge/presentation/screens/home/homepage.dart';
import 'package:unilodge/presentation/screens/home/listing_details_screen.dart';
import 'package:unilodge/presentation/screens/home/type_listing_screen.dart';
import 'package:unilodge/presentation/screens/your_listing/edit_listing_post.dart';
import 'package:unilodge/presentation/screens/your_listing/your_listing_details.dart';
import 'package:unilodge/presentation/screens/profile/user_profile.dart';
import 'package:unilodge/presentation/screens/listing/post_accommodation.dart';
import 'package:unilodge/presentation/screens/listing/post_location.dart';
import 'package:unilodge/presentation/screens/listing/post_price.dart';
import 'package:unilodge/presentation/screens/listing/post_facility.dart';
import 'package:unilodge/presentation/screens/listing/post_image.dart';
import 'package:unilodge/presentation/screens/listing/post_review.dart';
import 'package:unilodge/presentation/onboardingscreen/onboarding_view.dart';
import 'package:unilodge/presentation/splashscreen/pages/spash_screen.dart';
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
    builder: (context, state) =>
        const SplashScreen(), // Start with splash screen
  ),
  GoRoute(
    path: '/onboarding',
    builder: (context, state) => const OnboardingView(),
    ),
  GoRoute(
    path: '/account-selection-login',
    builder: (context, state) => const AccountSelectionLogin(),
  ),
  GoRoute(
    path: '/account-selection-signup',
    builder: (context, state) => const AccountSelectionSignup(),
  ),
  GoRoute(
    path: '/login',
    builder: (context, state) => const Login(),
  ),
  GoRoute(
    path: '/sign-up',
    builder: (context, state) => const SignUp(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomePage(),
  ),
  GoRoute(
    path: '/listings',
    builder: (context, state) => const HomePage(
      initialTabIndex: 1,
    ),
  ),
  GoRoute(
    path: '/favorites',
    builder: (context, state) => const HomePage(
      initialTabIndex: 2,
    ),
  ),
  GoRoute(
    path: '/messages',
    builder: (context, state) => const HomePage(
      initialTabIndex: 3,
    ),
  ),
  GoRoute(
    path: '/listing-detail/:id',
    builder: (context, state) {
      // Retrieve the listing ID from the route parameters
      final listingId = state.pathParameters['id'];

      final listing =
          dummyListings.firstWhere((listing) => listing.id == listingId);

      return ListingDetailScreen(listing: listing);
    },
  ),
  GoRoute(
    path: '/post-accommodation',
    builder: (context, state) => const PostAccommodation(),
  ),
  GoRoute(
    path: '/post-location',
    builder: (context, state) => const PostLocation(),
  ),
  GoRoute(
    path: '/post-price',
    builder: (context, state) => const PostPrice(),
  ),
  GoRoute(
    path: '/post-facility',
    builder: (context, state) => const PostFacility(),
  ),
  GoRoute(
    path: '/post-image',
    builder: (context, state) => const Postimage(),
  ),
  GoRoute(
    path: '/post-review',
    builder: (context, state) => const Postreview(),
  ),
  GoRoute(
    path: '/user-profile',
    builder: (context, state) => const UserProfile(),
  ),
  GoRoute(
    path: '/verify-email',
    builder: (context, state) {
      final extras = state.extra as Map<String, dynamic>;
      final email = extras['email_address'] as String;
      final token = extras['token'] as String;

      return VerifyEmail(email_address: email, token: token);
    },
  ),
  GoRoute(
    path: '/forget-password',
    builder: (context, state) => const ForgetPassword(),
  ),
  GoRoute(
    path: '/your-listing-detail/:id',
    builder: (context, state) {
      // Retrieve the listing ID from the route parameters
      final yourListingId = state.pathParameters['id'];

      final yourListing =
          dummyListings.firstWhere((listing) => listing.id == yourListingId);

      return YourListingDetails(listing: yourListing);
    },
  ),
  GoRoute(
    path: '/edit-listing-post',
    builder: (context, state) => const EditListingPost(),
  ),
  GoRoute(
    path: '/type-listing/:type',
    builder: (context, state) {
      final type = state.pathParameters['type'];
      return TypeListingScreen(appbarTitle: type!);
    },
  ),
]);
