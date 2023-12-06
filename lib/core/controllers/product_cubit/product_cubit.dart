import 'package:bloc/bloc.dart';
import 'package:ecommerce_trainning/core/controllers/product_cubit/product_states.dart';
import 'package:ecommerce_trainning/core/network/constants.dart';
import 'package:ecommerce_trainning/core/network/remote/dio_helper.dart';
import 'package:ecommerce_trainning/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductStates> {
  ProductCubit() : super(ProductInitState());

  static ProductCubit get(context) => BlocProvider.of(context);

  ProductsModel? productsModel;

  void getHomeProducts() {
    DioHelperStore.getData(url: ApiConstants.productApi)
        .then(
          (value) {
            productsModel = ProductsModel.fromJson(value.data);
            print(productsModel!.product!.length);
            emit(ProductFetchState());
          },
        )
        .catchError(
          (error) {
            print(error.toString());
            emit(ProductFailedState());
          },
        );
  }
}
