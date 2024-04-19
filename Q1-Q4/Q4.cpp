void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId)
{
    // Find player from online players by name
    Player *player = g_game.getPlayerByName(recipient);

    // If player is not online try to find it in offline players and store it in a temporary object
    if (!player)
    {
        player = new Player(nullptr);

        if (!IOLoginData::loadPlayerByName(player, recipient))
        {
            // If player was not found, deallocate the dynamic memory that was allocated to our temporary object
            delete player;
            return;
        }
    }

    // Create an item by item ID
    Item *item = Item::CreateItem(itemId);

    // If item could not be created and the player is offline deallocate the dynamic memory that was allocated to our temporary player object
    if (!item)
    {
        if (player->isOffline())
            delete player;
        return;
    }

    // Add item to the player
    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    // If the player is offline save its data and deallocate its memory space
    if (player->isOffline())
    {
        IOLoginData::savePlayer(player);
        delete player;
    }
}