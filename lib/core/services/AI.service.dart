import 'package:kalory/core/domains/ai.repository.dart';

var aiService = AIService();

class AIService {
  var aiRepository = AIRepository();

  Future<void> getTodoCategory(String itemName) async {
    return await aiRepository.getTodoCategory(itemName);
  }
}
