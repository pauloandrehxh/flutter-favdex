import 'package:get/get.dart';
import 'package:favdex/data/models/pokemon_model.dart';
import 'package:favdex/data/providers/poke_api_provider.dart';

class DetailsController extends GetxController {
  final PokeApiProvider provider = PokeApiProvider();
  
  var pokemon = Rxn<PokemonModel>();
  var isLoading = true.obs;
  var isError = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Recebe o Pokemon clicado na Home
    final PokemonModel passedPokemon = Get.arguments as PokemonModel;
    pokemon.value = passedPokemon;
    
    // Dispara a busca para pegar os detalhes completos
    fetchDetails(passedPokemon.name);
  }

  Future<void> fetchDetails(String name) async {
    isLoading.value = true;
    isError.value = false;
    try {
      final details = await provider.getPokemonDetails(name);
      pokemon.value = details; // Substitui o pokemon básico pelo completo
    } catch (e) {
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
