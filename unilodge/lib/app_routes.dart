import 'package:go_router/go_router.dart';
import 'package:unilodge/data/dummy_data/dummy_data.dart';
import 'package:unilodge/presentation/auth/pages/accountSelectionLogin.dart';
import 'package:unilodge/presentation/auth/pages/accountSelectionSignUp.dart';
import 'package:unilodge/presentation/auth/pages/forget_password.dart';
import 'package:unilodge/presentation/auth/pages/login.dart';
import 'package:unilodge/presentation/auth/pages/signUp.dart';
import 'package:unilodge/presentation/auth/pages/verify_email.dart';
import 'package:unilodge/presentation/home/pages/homepage.dart';
import 'package:unilodge/presentation/home/pages/listingDetailScreen.dart';
import 'package:unilodge/presentation/home/pages/typeListingScreen.dart';
import 'package:unilodge/presentation/listings/pages/editListingPost.dart';
import 'package:unilodge/presentation/listings/pages/yourListingDetails.dart';
import 'package:unilodge/presentation/profile/pages/userProfile.dart';
import 'package:unilodge/presentation/listing/pages/postAccommodation.dart';
import 'package:unilodge/presentation/listing/pages/postLocation.dart';
import 'package:unilodge/presentation/listing/pages/PostPrice.dart';
import 'package:unilodge/presentation/listing/pages/postFacility.dart';
import 'package:unilodge/presentation/listing/pages/postImage.dart';
import 'package:unilodge/presentation/listing/pages/postReview.dart';
import 'package:unilodge/presentation/splashscreen/pages/spashScreen.dart';

final GoRouter appRouter = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) =>
        const SplashScreen(), // Start with splash screen
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
